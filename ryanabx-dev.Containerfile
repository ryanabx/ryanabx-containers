# SPDX-license-identifier: MIT
FROM fedora:rawhide

# Install packages
COPY install-packages.sh .
RUN chmod +x ./install-packages.sh && ./install-packages.sh && rm ./install-packages.sh