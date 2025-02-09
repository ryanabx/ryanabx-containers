![Logo](res/logo.png)

---

This repo contains all of my container files for development, and for my operating system! (See: [bootc](https://github.com/containers/bootc) and [rpm-ostree](https://github.com/coreos/rpm-ostree))


## Bootc containers

### How to build an image

Install osbuild-selinux:

```shell
sudo dnf install -y osbuild-selinux
```

Create a `./config.toml` in the bootc Containerfile's directory

```toml
[[customizations.user]]
name = "ryanbrue"
password = "password"
groups = ["wheel"]
```

Then, run bootc image builder:

```shell
sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v $(pwd)/config.toml:/config.toml:ro \
    -v $(pwd)/output:/output \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type anaconda-iso \
    --rootfs btrfs \
    <image>
```

Types we care about: `qcow2`, `anaconda-iso`

## Create a dev container with graphical sharing

```shell
podman run -it \
    --env WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    --volume $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/run/$WAYLAND_DISPLAY:ro \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
    --device /dev/dri:/dev/dri \
    ghcr.io/ryanabx/ryanabx-dev:latest
```
