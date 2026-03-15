# SPDX-license-identifier: MIT

# This is the container used for my Fedora toolbox! To use it, run this command:
# toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
# OR to run as root (which is needed for stuff like pmbootstrap)
# sudo toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
FROM quay.io/fedora-ostree-desktops/kinoite:43

# Install packages
COPY ../scripts/install_packages.sh /tmp/install_packages.sh
RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh