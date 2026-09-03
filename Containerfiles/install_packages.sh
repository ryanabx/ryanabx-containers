#!/bin/sh
# Install packages

# Text editors
dnf install -y \
    helix

# VCS and package collaboration
dnf install -y \
    git git-lfs \
    fedpkg fedora-packager \
    gh pagure-cli b4

# Rust
dnf install -y \
    rust cargo rust-analyzer rustfmt clippy \
    mold

# C/C++ compilers and build systems
dnf install -y \
    gcc gcc-c++ clang clang-devel \
    make automake cmake just \
    lld binutils binutils-devel binutils-gold \
    kernel-devel glibc-devel ccache

# Mobile and embedded
dnf install -y \
    android-tools

# JavaScript, .NET, and Perl
dnf install -y \
    nodejs npm \
    dotnet-sdk-10.0 \
    perl-core

# GUI and Wayland development libraries
dnf install -y \
    wayland-devel libxkbcommon-devel fuse-devel libinput-devel \
    gstreamer1-plugins-base-devel \
    gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel \
    libsoup-devel webkit2gtk4.1-devel \
    libseat-devel pixman-devel flatpak-devel

# OpenRCT2 missing dev libraries
dnf install -y \
    sdl2-compat-devel openssl-libs \
    libzip-devel libicu-devel \
    libvorbis-devel json-devel innoextract flac-devel

# Misc tools
dnf install -y \
    squashfs-tools \
    mkosi \
    wget \
    rsync \
    htop \
    dtc \
    tcpdump

# Gaming
dnf install -y \
    steam-devices \
    vkmark

# Finally, after installing, clean all
dnf clean all
