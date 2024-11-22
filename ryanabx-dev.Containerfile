# SPDX-license-identifier: MIT
FROM fedora:rawhide

# Install packages
COPY install-packages.sh .
RUN ./install-packages.sh && rm ./install-packages.sh