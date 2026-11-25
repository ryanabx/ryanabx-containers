# SPDX-license-identifier: MIT

FROM quay.io/fedora-ostree-desktops/kinoite:45

# Set to "true" to build the NVIDIA variant (driver + CUDA, see
# install_nvidia.sh). Published as ryanabx-kinoite:nvidia.
ARG NVIDIA=false
# Which NVIDIA kernel module to build: "open" (RPM Fusion's choice for any
# GPU it supports) or "proprietary". Published as ryanabx-kinoite:nvidia and
# ryanabx-kinoite:nvidia-proprietary.
ARG NVIDIA_KMOD=open

# Install packages, then refresh rpm-ostree's base rpmdb. rpm-ostree only
# overrides (replace/remove) packages listed in rpm-ostree-base-db, which
# compose hardlinks to /usr/share/rpm; dnf breaks that link, so without this
# the packages added here can't be overridden client-side. Done in the same
# layer so the hardlinks don't force a copy of the rpmdb.
COPY Containerfiles/install_packages.sh /tmp/install_packages.sh
COPY Containerfiles/install_nvidia.sh /tmp/install_nvidia.sh
RUN chmod +x /tmp/install_packages.sh /tmp/install_nvidia.sh && \
    /tmp/install_packages.sh && \
    if [ "${NVIDIA}" = "true" ]; then NVIDIA_KMOD="${NVIDIA_KMOD}" /tmp/install_nvidia.sh; fi && \
    rm -rf /usr/lib/sysimage/rpm-ostree-base-db && \
    cp -al /usr/share/rpm /usr/lib/sysimage/rpm-ostree-base-db
