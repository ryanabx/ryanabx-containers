# Building with a Fedora base, may be subject to change pending https://github.com/containers/bootc/issues/865
FROM quay.io/fedora/fedora-bootc:41

# Install other necessities
RUN << EOF
    dnf install -y flatpak --exclude=firefox --exclude=rootfiles
    dnf install -y @kde-desktop-environment @container-management --exclude=firefox --exclude=rootfiles
    dnf clean all
EOF 

COPY extra/_install-flatpaks /usr/bin/