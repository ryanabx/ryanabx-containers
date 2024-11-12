# cosmOS, copyright Ryan Brue <ryanbrue.dev@gmail.com>
# SPDX-license-identifier: MIT
FROM quay.io/fedora-ostree-desktops/base:41

# Install comps groups
RUN dnf install -y \
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
    @vlc

# Install copr
RUN dnf copr enable -y ryanabx/cosmic-epoch
RUN dnf install -y cosmic-desktop
RUN dnf upgrade --refresh -y
RUN dnf clean all