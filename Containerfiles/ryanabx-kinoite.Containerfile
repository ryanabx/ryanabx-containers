# SPDX-license-identifier: MIT

# Base release: a stable Fedora version (e.g. 45) or "rawhide"
ARG FEDORA_VERSION=45
FROM quay.io/fedora-ostree-desktops/kinoite:${FEDORA_VERSION}

# Install packages
COPY Containerfiles/install_packages.sh /tmp/install_packages.sh
RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh
