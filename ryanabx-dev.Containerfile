# SPDX-license-identifier: MIT

# This is the container used for my Fedora toolbox! To use it, run this command:
# toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
# OR to run as root (which is needed for stuff like pmbootstrap)
# sudo toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
FROM fedora:43

RUN rm /etc/yum.repos.d/fedora-cisco-openh264.repo

RUN \
# Import vscode to the container
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
    && \
    dnf install -y \
# Essentials
        wget \
# Applications
        code firefox \
# Version Control and Packaging
        git git-lfs \
        gh pagure-cli \
        fedpkg fedora-packager \
# Rust utils
        rust cargo rust-analyzer rustfmt clippy \
# C/C++ utils
        gcc gcc-c++ clang clang-devel \
# Build systems
        make automake cmake just
# Linux Phone Stuff
        android-tools pmbootstrap \
# Ruby utils
        ruby ruby-devel \
# Javascript utils
        nodejs \
# C# utils
        dotnet-sdk-9.0 \
# A bunch of common libraries
        wayland-devel libxkbcommon-devel fuse-devel libinput-devel \
        squashfs-tools gstreamer1-plugins-base-devel \
        gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel \
        lld mold kernel-devel glibc-devel binutils binutils-devel binutils-gold \
        libsoup-devel webkit2gtk4.0-devel webkit2gtk4.1-devel \
        libseat-devel pixman-devel \
# Image building stuff
        osbuild-selinux mkosi \
# Finally, after installing, clean all
        && dnf clean all
