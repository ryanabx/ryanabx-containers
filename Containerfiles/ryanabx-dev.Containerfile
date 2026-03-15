# SPDX-license-identifier: MIT

# This is the container used for my Fedora toolbox! To use it, run this command:
# toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
# OR to run as root (which is needed for stuff like pmbootstrap)
# sudo toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
FROM fedora:43

RUN rm /etc/yum.repos.d/fedora-cisco-openh264.repo

# Install packages
COPY ../scripts/install_packages.sh /tmp/install_packages.sh
RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh

# https://github.com/containers/toolbox/issues/235
RUN echo "[libdefaults]" >> /etc/krb5.conf.d/0_file_ccache && echo "    default_ccache_name = FILE\:/tmp/krb5.ccache" >> /etc/krb5.conf.d/0_file_ccache

# Additional Language servers
RUN npm install -g typescript-language-server typescript
# RUN dotnet tool install -g csharp-ls

# Set default editor to helix
ENV EDITOR="hx"
