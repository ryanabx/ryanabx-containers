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
    git git-lfs
    fedpkg fedora-packager
    gh pagure-cli b4
    # Rust
    rust cargo rust-analyzer rustfmt clippy
    mold
    # C/C++ compilers and build systems
    gcc gcc-c++ clang clang-devel
    make automake cmake just
    lld binutils binutils-devel binutils-gold
    kernel-devel glibc-devel ccache
    swig
    # Mobile and embedded
    android-tools busybox libfdt-devel
    # JavaScript, .NET, and Perl
    nodejs npm
    dotnet-sdk-10.0
    perl-core
    # GUI and Wayland development libraries
    wayland-devel libxkbcommon-devel fuse-devel libinput-devel
    gstreamer1-plugins-base-devel
    gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel
    libsoup-devel webkit2gtk4.1-devel
    libseat-devel pixman-devel flatpak-devel
    # OpenRCT2 missing dev libraries
    sdl2-compat-devel openssl-libs
    libzip-devel libicu-devel
    libvorbis-devel json-devel innoextract flac-devel
    # Misc tools
    squashfs-tools
    mkosi
    wget
    rsync
    htop
    dtc
    tcpdump
    yamllint
    # Gaming
    steam-devices
    vkmark
)

# Execute dnf by expanding the array
dnf install -y \
    --setopt=deltarpm=False \
    "${packages[@]}"

# Finally, after installing, clean all
dnf clean all
