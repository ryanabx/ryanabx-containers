# cosmOS, copyright Ryan Brue <ryanbrue.dev@gmail.com>
# SPDX-license-identifier: MIT
FROM quay.io/fedora-ostree-desktops/cosmic-atomic:42

RUN dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y cosmic-desktop
