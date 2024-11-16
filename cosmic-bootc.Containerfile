# Building with a Fedora base, may be subject to change pending https://github.com/containers/bootc/issues/865
FROM quay.io/fedora/fedora-bootc:41

# Install other necessities
RUN dnf install -y flatpak --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles

# Install environment group
RUN dnf install -y @cosmic-desktop-environment --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
# Install latest git packages
RUN dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y --best cosmic-desktop --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
RUN dnf upgrade --refresh -y --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
# Clean dnf
RUN dnf clean all