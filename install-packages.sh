#!/bin/bash

rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

dnf install -y \
    code firefox \
    git git-lfs \
    rust cargo rust-analyzer rustfmt clippy \
    wayland-devel libxkbcommon-devel fuse-devel libinput-devel \
    squashfs-tools gstreamer1-plugins-base-devel \
    gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel \
    lld make automake gcc gcc-c++ clang clang-devel mold kernel-devel glibc-devel binutils binutils-devel binutils-gold \
    libsoup-devel webkit2gtk4.0-devel webkit2gtk4.1-devel \
    gh pagure-cli \
    fedpkg fedora-packager \
    android-tools pmbootstrap \
    osbuild-selinux \
    ruby ruby-devel \
    nodejs \
    libseat-devel pixman-devel \
    cmake \
    helix \
    mkosi wget

dnf clean all
