# SPDX-license-identifier: MIT

FROM quay.io/fedora-ostree-desktops/kinoite:44

# Install packages
COPY install_packages.sh /tmp/install_packages.sh
RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh
