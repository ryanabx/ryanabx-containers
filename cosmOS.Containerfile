# cosmOS, copyright Ryan Brue <ryanbrue.dev@gmail.com>
# SPDX-license-identifier: MIT
FROM quay.io/fedora-ostree-desktops/base:41

RUN \
    # Install comps groups
    dnf install -y \
    @admin-tools \
    @base-graphical \
    @core \
    # @cosmic-desktop \
    # @cosmic-desktop-apps \
    @desktop-accessibility \
    @dial-up \
    @firefox \
    @fonts \
    @guest-desktop-agents \
    @hardware-support \
    @input-methods \
    @libreoffice \
    @multimedia \
    @networkmanager-submodules \
    @printing \
    @standard \
    @vlc && \
    # Install copr
    dnf copr enable -y ryanabx/cosmic-epoch && \
    dnf install -y cosmic-desktop && \
    dnf upgrade --refresh -y && \
    dnf clean all

COPY extra/cosmOS_overlay /