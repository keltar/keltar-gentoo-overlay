# keltar's personal Gentoo overlay

## Install with eselect repository

```
emerge --ask app-eselect/eselect-repository
eselect repository add keltar-overlay git https://github.com/keltar/keltar-gentoo-overlay
```

## Install with layman (deprecated)

```
emerge --ask app-portage/layman
layman -o https://raw.githubusercontent.com/keltar/keltar-gentoo-overlay/main/layman-repositories.xml -f -a keltar-overlay
```
