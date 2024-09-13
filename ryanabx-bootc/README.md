### List flatpaks installed

```shell
flatpak list --app --columns=application
```

### Install flatpaks

```shell
xargs -a flatpaks.txt -r -- flatpak install -y flathub
```