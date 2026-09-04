<p align="center">
  <img src="logo.png" width="200" alt="ryanabx-containers logo" />
</p>

<h1 align="center">ryanabx-containers</h1>

<p align="center">
  My container images: full <b>OS images</b> for rpm-ostree/bootc, and a <b>toolbox</b> image for development.
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/ryanabx/ryanabx-containers" alt="License" />
  <img src="https://img.shields.io/badge/base-Fedora%2044-fedorawhite?labelColor=f31226" alt="Base" />
  <img src="https://img.shields.io/badge/registry-ghcr.io-5c6ac4?logo=github" alt="Registry" />
  <img src="https://img.shields.io/badge/container--runtime-podman-blue?logo=podman" alt="Runtime" />
</p>

---

## What's in here?

This repository contains all of my container definitions, built by
[GitHub Actions](.github/workflows) and published to
[GHCR](https://ghcr.io/ryanabx). They fall into two categories:

- **OS images** — full, bootable images built on top of Fedora's
  [rpm-ostree](https://github.com/coreos/rpm-ostree) desktop images.
  These are meant to be *deployed as an operating system* (see
  [bootc](https://github.com/containers/bootc) and
  [rpm-ostree](https://github.com/coreos/rpm-ostree)), not run like a
  normal container.
- **Toolbox images** — plain container images with my development
  toolchain pre-installed, meant to be used with
  [toolbox](https://github.com/containers/toolbox) on an immutable
  (Fedora Silverblue/Kinoite etc.) host.

| Image | Type | Base | Description |
| --- | --- | --- | --- |
| [ryanabx/ryanabx-dev](#ghcrioryanabxryanabx-dev) | Toolbox | `fedora:44` | My personal development toolbox |
| [ryanabx/ryanabx-kinoite](#ghcrioryanabxryanabx-kinoite) | OS image | `fedora-ostree-desktops/kinoite:44` | Kinoite + my package set |
| [ryanabx/cosmic-nightly](#ghcrioryanabxcosmic-nightly) | OS image | `fedora-ostree-desktops/cosmic-atomic:44` | Fedora COSMIC with my nightly COPR |

---

# Containers

## ghcr.io/ryanabx/ryanabx-dev

<p>
  <img src="https://img.shields.io/badge/ghcr.io%2Fryanabx-ryanabx--dev-5c6ac4?logo=github" alt="GHCR" />
  <img src="https://img.shields.io/badge/base-fedora%3A44-fedorawhite?labelColor=f31226" alt="Base" />
  <img src="https://img.shields.io/github/actions/workflow/status/ryanabx/ryanabx-containers/ryanabx-dev-build.yml" alt="Build status" />
</p>

My toolbox container. It contains everything I need to develop from an
immutable OS: language toolchains, linters, language servers, editors,
and a bunch of other utilities. It's a regular container image — you
don't boot it, you *run software in it*.

### Usage

Create a toolbox from the image:

```shell
toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
```

Then enter it any time with:

```shell
toolbox enter
```

For example, to run VS Code inside it:

```shell
toolbox run code
```

> [!NOTE]
> Some tasks (such as `pmbootstrap`) need access to the host's device
> nodes — create the toolbox as root for those:
>
> ```shell
> sudo toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
> ```

## ghcr.io/ryanabx/ryanabx-kinoite

<p>
  <img src="https://img.shields.io/badge/ghcr.io%2Fryanabx-ryanabx--kinoite-5c6ac4?logo=github" alt="GHCR" />
  <img src="https://img.shields.io/badge/base-kinoite%3A44-fedorawhite?labelColor=f31226" alt="Base" />
  <img src="https://img.shields.io/github/actions/workflow/status/ryanabx/ryanabx-containers/ryanabx-kinoite-build.yml" alt="Build status" />
</p>

An [rpm-ostree](https://github.com/coreos/rpm-ostree) image built on
top of [Fedora Kinoite](https://docs.fedoraproject.org/en-US/echo-desktop/kinoite/)
with the extra packages I use installed on top. This is the image I use
for my day-to-day operating system!

### Usage

On an existing rpm-ostree machine, you can deploy this image as the
system:

```shell
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/ryanabx-kinoite:latest
```

or use it as a base layer for your own
[bootc](https://github.com/containers/bootc)-based image:

```dockerfile
FROM ghcr.io/ryanabx/ryanabx-kinoite:latest
RUN dnf install -y <something>
```

## ghcr.io/ryanabx/cosmic-nightly

<p>
  <img src="https://img.shields.io/badge/ghcr.io%2Fryanabx-cosmic--nightly-5c6ac4?logo=github" alt="GHCR" />
  <img src="https://img.shields.io/badge/base-cosmic--atomic%3A44-fedorawhite?labelColor=f31226" alt="Base" />
  <img src="https://img.shields.io/github/actions/workflow/status/ryanabx/ryanabx-containers/cosmic-nightly-build.yml" alt="Build status" />
</p>

Basically just Fedora COSMIC but with my
[nightly COPR](https://copr.fedoraproject.org/coprs/ryanabx/cosmic-epoch)
attached. This comes with the latest COSMIC packages before Fedora
upstream gets them! I use this personally for Fedora COSMIC and COSMIC
upstream development.

Like `ryanabx-kinoite`, this is a full
[rpm-ostree](https://github.com/coreos/rpm-ostree) OS image:

```shell
sudo ostree admin deploy --image=ghcr.io/ryanabx/cosmic-nightly:latest
```

---

# Verifying Signatures

Every image published by the workflows in [`.github/workflows/`](.github/workflows)
is signed with [cosign](https://docs.sigstore.dev/cosign) using
[keyless Sigstore](https://docs.sigstore.dev/overview): the signature is made
with GitHub's OIDC identity for this repository (no long-lived signing key),
and is stored as a sibling OCI artifact next to the image on GHCR.

Verify a signature with:

```shell
cosign verify \
  --certificate-identity ".*ryanabx-containers.*" \
  --certificate-oidc-issuer "https://github.com" \
  ghcr.io/ryanabx/ryanabx-kinoite:latest
```

Replace the image reference as needed (`ryanabx-dev`, `cosmic-nightly`). A
successful run prints the embedded GitHub certificate, which includes the
repository and workflow that produced the image. Verify against a digest
(`ghcr.io/ryanabx/ryanabx-kinoite@sha256:…`) to pin an exact build.

> [!NOTE]
> These signatures are not checked automatically by
> `rpm-ostree`/`ostree` when pulling from `ostree-unverified-registry:`;
> run `cosign verify` yourself (e.g. before a `rebase` or in an update
> script) if you want an extra trust gate.

---

# Development

- Container definitions live in [`Containerfiles/`](Containerfiles/).
- CI workflows live in [`.github/workflows/`](.github/workflows); images
  are rebuilt on push and on a daily cron, published to GHCR, and signed
  with keyless Sigstore (see [Verifying Signatures](#verifying-signatures)).
- Notes on building rpm-ostree images locally with `bootc` live in
  [`docs/notes.md`](docs/notes.md).

## License

Distributed under the [MIT License](LICENSE).
