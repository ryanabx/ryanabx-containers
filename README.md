![Logo](res/logo.png)

---

This repo contains all of my container files for development, and for my operating system! (See: [bootc](https://github.com/containers/bootc) and [rpm-ostree](https://github.com/coreos/rpm-ostree))


# Containers

## ghcr.io/ryanabx/ryanabx-dev

This is my toolbox container. It contains everything I need to develop from an immutable OS. To use this image, run this command:

```shell
toolbox create -i ghcr.io/ryanabx/ryanabx-dev:latest
```

To run vscode within it, run this:

```shell
toolbox run code
```

## ghcr.io/ryanabx/cosmic-nightly

Basically just Fedora COSMIC but with my nightly copr attached. This comes with the latest COSMIC packages before the Fedora upstream gets them! I use this personally for Fedora COSMIC and COSMIC upstream development.
