#!/bin/sh

# Install common packages across ryanabx-dev and ryanabx-bootc
dnf install -y \
    helix \
    git git-lfs \
    wget \
    fedpkg fedora-packager \
    gh pagure-cli \
    rust cargo rust-analyzer rustfmt clippy \
    gcc gcc-c++ clang clang-devel \
    make automake cmake just \
    android-tools pmbootstrap \
    nodejs npm \
    dotnet-sdk-10.0 \
    perl-core \
    wayland-devel libxkbcommon-devel fuse-devel libinput-devel \
    squashfs-tools gstreamer1-plugins-base-devel \
    gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel \
    lld mold kernel-devel glibc-devel binutils binutils-devel binutils-gold \
    libsoup-devel webkit2gtk4.1-devel \
    libseat-devel pixman-devel flatpak-devel \
    mkosi \
    steam-devices \
    rsync
# Finally, after installing, clean all
dnf clean all
