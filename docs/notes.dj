# Bootc image notes

```shell
cd ryanabx-os-bootc
mkdir output
sudo podman build -t ryanabx-os-bootc:latest .
sudo podman run \
--rm \
-it \
--privileged \
--pull=newer \
--security-opt label=type:unconfined_t \
-v $(pwd)/config.toml:/config.toml:ro \
-v $(pwd)/output:/output \
-v /var/lib/containers/storage:/var/lib/containers/storage \
quay.io/centos-bootc/bootc-image-builder:latest \
--type qcow2 \
--rootfs btrfs \
--local localhost/ryanabx-os-bootc:latest
```

> NOTE: Change to `anaconda-iso` for iso install
> NOTE2: Could also change btrfs to ext4 if you want