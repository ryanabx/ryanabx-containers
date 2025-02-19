# SPDX-license-identifier: MIT
FROM fedora:42


# Install packages
COPY install-packages.sh .
RUN chmod +x ./install-packages.sh && ./install-packages.sh && rm ./install-packages.sh
