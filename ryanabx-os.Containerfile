# Building with a Fedora base, may be subject to change pending https://github.com/containers/bootc/issues/865
FROM quay.io/fedora-ostree-desktops/silverblue:41


# Install other necessities
# RUN \
#     set -eux && \
#     dnf install -y flatpak --exclude=firefox --exclude=rootfiles && \
#     dnf install -y @cosmic-desktop-environment @container-management --exclude=firefox --exclude=rootfiles && \
#     dnf clean all

# Flatpak install script
COPY extra/_install-flatpaks /usr/bin/
COPY extra/flatpak-list.txt /usr/share/ryanabx/

# Install packages
# COPY install-packages.sh .
# RUN chmod +x ./install-packages.sh && ./install-packages.sh && rm ./install-packages.sh

# Install COSMIC
RUN dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y cosmic-desktop && dnf clean all
