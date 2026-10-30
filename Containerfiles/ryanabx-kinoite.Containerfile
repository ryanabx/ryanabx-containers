# SPDX-license-identifier: MIT

# Base release: a stable Fedora version (e.g. 45) or "rawhide"
ARG FEDORA_VERSION=45
FROM quay.io/fedora-ostree-desktops/kinoite:${FEDORA_VERSION}

# Install packages, then refresh rpm-ostree's base rpmdb. rpm-ostree only
# overrides (replace/remove) packages listed in rpm-ostree-base-db, which
# compose hardlinks to /usr/share/rpm; dnf breaks that link, so without this
# the packages added here can't be overridden client-side. Done in the same
# layer so the hardlinks don't force a copy of the rpmdb.
COPY Containerfiles/install_packages.sh /tmp/install_packages.sh
RUN chmod +x /tmp/install_packages.sh && /tmp/install_packages.sh && \
    rm -rf /usr/lib/sysimage/rpm-ostree-base-db && \
    cp -al /usr/share/rpm /usr/lib/sysimage/rpm-ostree-base-db
