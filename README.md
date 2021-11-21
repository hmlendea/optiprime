[![Donate](https://img.shields.io/badge/-%E2%99%A5%20Donate-%23ff69b4)](https://hmlendea.go.ro/fund.html) [![Build Status](https://github.com/hmlendea/optiprime/actions/workflows/bash.yml/badge.svg)](https://github.com/hmlendea/optiprime/actions/workflows/bash.yml) [![Latest GitHub release](https://img.shields.io/github/v/release/hmlendea/optiprime)](https://github.com/hmlendea/optiprime/releases/latest)

# About

Bash script to run applications efficiently using the Nvidia GPU on Linux, using bumblebee and optirun.

# Installation

## Arch Linux

Install it using [this PKGBUILD](https://github.com/hmlendea/PKGBUILDs/tree/master/pkg/optiprime).

## Other distros

Copy `optiprime.sh` to `/usr/bin/optiprime` and make it executable:
```bash
cp "optiprime.sh" "/usr/bin/optiprime"
chmod +x "/usr/bin/optiprime"
```

# Usage

Simply run `optiprime` and send the application you wish to run as an argument.

Example:
```bash
optiprime steam
```

**Note**: You can edit that application's desktop file _(e.g. /usr/share/applications/steam.desktop)_ to use `optiprime` in its `Exec` command, so that clicking its icon on your desktop will launch it using optiprime.
