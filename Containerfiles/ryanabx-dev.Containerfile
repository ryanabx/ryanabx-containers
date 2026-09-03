# SPDX-license-identifier: MIT

# This is the container used for my Fedora toolbox! To use it, run this command:
# toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
# OR to run as root (which is needed for stuff like pmbootstrap)
# sudo toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
FROM fedora:44

RUN rm /etc/yum.repos.d/fedora-cisco-openh264.repo

# Install packages
COPY Containerfiles/install_packages.sh /tmp/install_packages.sh
RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh

# Additional Language servers
RUN npm install -g typescript-language-server typescript
# RUN dotnet tool install -g csharp-ls

# Set default editor to helix
ENV EDITOR="hx"
