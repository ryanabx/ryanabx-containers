#!/bin/bash
# Install the NVIDIA driver (with CUDA support) from RPM Fusion.
#
# akmod-nvidia normally builds its kernel module at boot for the running
# kernel. In a container build the "running" kernel is the build host's,
# so instead we build the kmod explicitly for the kernel shipped in the
# image. akmods packages the result as kmod-nvidia-<kver> and installs it,
# so the module is baked into the image and nothing is compiled on boot.
set -euo pipefail

# The kernel shipped in the image (not the build host's `uname -r`)
read -r KV KR KARCH < <(rpm -q kernel-core --qf '%{VERSION} %{RELEASE} %{ARCH}\n' | tail -n1)
KVER="${KV}-${KR}.${KARCH}"
FEDORA="$(rpm -E %fedora)"

# akmods needs a writable /var/tmp and root's home (/root -> /var/roothome)
mkdir -p /var/tmp /var/roothome
chmod 1777 /var/tmp

# The release RPMs require "/usr/share/dnf5/libdnf.conf.d/" with a trailing
# slash, which neither dnf5 nor rpm can match against libdnf5's file list
# (the directory exists). Check the real requirements ourselves, then
# install without rpm's dependency check. They also carry the repo GPG
# keys, so (like `dnf install <url>`, which skips GPG checks for local
# packages) they can't be signature-checked; packages from the repos are.
test -d /usr/share/dnf5/libdnf.conf.d
rpm -q --whatprovides "system-release(${FEDORA})" > /dev/null
rpm -i --nodeps --nosignature \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA}.noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA}.noarch.rpm"

# Headers for the image's kernel, so akmods can build against it (akmods
# also needs the matching kernel-devel-matched). The base image often lags
# Fedora's updates repo, which only keeps the newest kernel, so fall back
# to the exact build from Fedora's Koji.
kernel_devel=()
for pkg in kernel-devel kernel-devel-matched; do
    if [ -n "$(dnf repoquery -q "${pkg}-${KVER}")" ]; then
        kernel_devel+=("${pkg}-${KVER}")
    else
        kernel_devel+=("https://kojipkgs.fedoraproject.org/packages/kernel/${KV}/${KR}/${KARCH}/${pkg}-${KVER}.rpm")
    fi
done

packages=(
    # Driver kmod source + userspace
    akmod-nvidia
    xorg-x11-drv-nvidia
    # CUDA driver support (libcuda, nvidia-smi, NVENC/NVDEC, ...)
    xorg-x11-drv-nvidia-cuda
    xorg-x11-drv-nvidia-cuda-libs
    # nvidia-suspend/resume/hibernate services
    xorg-x11-drv-nvidia-power
)

# On ostree systems akmod-nvidia's %post calls akmods-ostree-post to build
# the kmod as root, which is meant for rpm-ostree's client-side sandbox;
# in a container build akmodsbuild refuses to run as root and the whole
# transaction fails. Stub it out for the install (we build explicitly
# below), then restore it for anything layered client-side later.
dnf install -y --setopt=deltarpm=False akmods "${kernel_devel[@]}"
mv /usr/sbin/akmods-ostree-post /usr/sbin/akmods-ostree-post.orig
printf '#!/bin/sh\nexit 0\n' > /usr/sbin/akmods-ostree-post
chmod 755 /usr/sbin/akmods-ostree-post
dnf install -y --setopt=deltarpm=False "${packages[@]}"
mv -f /usr/sbin/akmods-ostree-post.orig /usr/sbin/akmods-ostree-post

# Build and install kmod-nvidia for the image's kernel
akmods --force --kernels "${KVER}" --kmod nvidia

# Fail the build if the modules didn't actually land in the image
if ! modinfo -k "${KVER}" nvidia nvidia-drm nvidia-modeset nvidia-uvm > /dev/null; then
    cat /var/cache/akmods/nvidia/*.failed.log 2>/dev/null || true
    echo "error: nvidia kmod was not built for ${KVER}" >&2
    exit 1
fi

# Keep the in-kernel NVIDIA drivers (nouveau, and the Rust nova-core/
# nova-drm, not built by Fedora's kernel today) from grabbing the GPU.
# Applied on deploy by bootc; see README for applying them manually.
mkdir -p /usr/lib/bootc/kargs.d
cat > /usr/lib/bootc/kargs.d/00-nvidia.toml <<'EOF'
kargs = ["rd.driver.blacklist=nouveau,nova_core,nova_drm", "modprobe.blacklist=nouveau,nova_core,nova_drm"]
EOF

rm -rf /var/cache/akmods/* /var/log/akmods/*
dnf clean all
