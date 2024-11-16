# Building with a Fedora base, may be subject to change pending https://github.com/containers/bootc/issues/865
FROM quay.io/fedora/fedora-bootc:41

RUN << EOF
    set -eux
    # Install other necessities
    dnf install -y flatpak --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
    # Install environment group
    dnf install -y @cosmic-desktop-environment --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
    # Install latest git packages
    dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y --best cosmic-desktop --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
    dnf upgrade --refresh -y --exclude=system-cosmic-config --exclude=firefox --exclude=rootfiles
    # Clean dnf
    dnf clean all
EOF