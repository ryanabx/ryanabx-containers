# SPDX-license-identifier: MIT
FROM fedora:42


RUN rm /etc/yum.repos.d/fedora-cisco-openh264.repo

# Install packages
COPY install-packages.sh .
RUN chmod +x ./install-packages.sh && ./install-packages.sh && rm ./install-packages.sh
