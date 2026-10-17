#!/bin/bash
# Install packages
#
# A single dnf transaction keeps repo metadata loading and dependency
# resolution to a single pass. deltarpm is disabled because delta RPMs
# only speed up in-place system upgrades, not fresh installs.

# Define the packages in an array with inline comments
packages=(
    # Text editors
    helix
    # VCS and package collaboration
    git git-lfs git-email
    fedpkg fedora-packager
    gh pagure-cli
    # Helpers for the patch-based workflow (Linux Kernel)
    b4 lei
    # Rust
    rust cargo rust-analyzer rustfmt clippy
    mold
    # Go
    go
    # C/C++ compilers and build systems
    # Most of it is for kernel devel
    gcc gcc-c++ clang clang-devel
    make automake cmake just
    lld binutils binutils-devel binutils-gold
    elfutils elfutils-devel elfutils-libs
    elfutils-libelf elfutils-libelf-devel
    kernel-devel glibc-devel ccache
    swig python3-devel
    # Other kernel deps
    asciidoc audit-libs-devel bindgen-cli
    bpftool capstone-devel dwarves glibc-static
    java-25-openjdk-devel kernel-rpm-macros libasan-static
    libbabeltrace-devel libbabeltrace2-devel libbpf-devel
    libcap-devel libcap-ng-devel libmnl-devel libnl3-devel
    libpfm-devel libtraceevent-devel libtracefs-devel libubsan
    liburing-devel newt-devel nss-tools numactl-devel
    pciutils-devel perl-generators pesign python3-docutils
    python3-jsonschema xmlto xxd
    # Mobile and embedded
    android-tools busybox libfdt-devel picocom
    # JavaScript, .NET, and Perl
    nodejs npm
    dotnet-sdk-10.0
    perl-core
    # GUI and Wayland development libraries
    wayland-devel libxkbcommon-devel libxkbcommon-x11-devel
    fuse-devel libinput-devel
    gstreamer1-plugins-base-devel
    gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel
    libsoup-devel webkit2gtk4.1-devel
    libseat-devel pixman-devel flatpak-devel alsa-lib-devel
    vulkan-headers vulkan-tools vulkan-loader-devel
    # OpenRCT2 missing dev libraries
    sdl2-compat-devel openssl-libs
    libzip-devel libicu-devel
    libvorbis-devel json-devel innoextract flac-devel
    # Video encoding (used by KRDP). NVIDIA has no VA-API encoder, so KRDP
    # falls back to software openh264 there.
    openh264 libva-utils
    # Hardware monitoring tools
    htop
    btop
    lm_sensors
    nvtop
    # Misc tools
    squashfs-tools
    mkosi
    wget
    rsync
    dtc
    tcpdump
    dos2unix
    yamllint
    # VPN
    tailscale
    # Gaming
    steam-devices
    vkmark
    igt-gpu-tools
    # Virtualization
    virt-manager
    qemu-system-aarch64
    qemu-system-riscv
)

# RPM Fusion ships the VA-API drivers with the H.264/HEVC encoders that
# Fedora strips out
dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Execute dnf by expanding the array
dnf install -y \
    --setopt=deltarpm=False \
    "${packages[@]}"

# Intel's full VA-API driver conflicts with (rather than obsoletes)
# Fedora's, so it has to be swapped in
dnf swap -y libva-intel-media-driver intel-media-driver

# Freeworld Mesa enables H.264/HEVC VA-API encoding on AMD. It pins the exact
# Mesa version, so it's kept out of the main transaction: if RPM Fusion lags
# behind a Fedora Mesa update, only this install fails.
dnf install -y mesa-va-drivers-freeworld

# Finally, after installing, clean all
dnf clean all
