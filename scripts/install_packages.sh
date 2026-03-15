#!/bin/sh

# Install common packages across ryanabx-dev and ryanabx-dev-ostree

# Import vscode to the container
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
# Install packages
dnf install -y \
    zsh \
    helix \
    wget \
    code \
    breeze-icon-theme breeze-cursor-theme google-noto-sans-fonts \
    git git-lfs \
    gh pagure-cli \
    fedpkg fedora-packager \
    rust cargo rust-analyzer rustfmt clippy \
    gcc gcc-c++ clang clang-devel \
    make automake cmake just \
    android-tools pmbootstrap \
    ruby ruby-devel \
    perl-core \
    nodejs \
    dotnet-sdk-9.0 \
    wayland-devel libxkbcommon-devel fuse-devel libinput-devel \
    squashfs-tools gstreamer1-plugins-base-devel \
    gdk-pixbuf2-devel pango-devel gtk3-devel glib2-devel \
    lld mold kernel-devel glibc-devel binutils binutils-devel binutils-gold \
    libsoup-devel webkit2gtk4.1-devel \
    libseat-devel pixman-devel flatpak-devel \
    osbuild-selinux mkosi \
    kwallet
# Finally, after installing, clean all
dnf clean all