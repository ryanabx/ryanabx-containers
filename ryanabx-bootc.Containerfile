# Building with a Fedora base, may be subject to change pending https://github.com/containers/bootc/issues/865
FROM quay.io/fedora/fedora-bootc:41

# Install other necessities
RUN dnf install -y flatpak --exclude=firefox --exclude=rootfiles

# Install environment group
RUN dnf install -y @kde-desktop-environment @container-management --exclude=firefox --exclude=rootfiles

COPY extra/_install-flatpaks /usr/bin/
# Clean dnf
RUN dnf clean all