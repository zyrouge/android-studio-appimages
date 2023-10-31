# Android Studio AppImages

[![Latest](https://img.shields.io/github/v/release/zyrouge/android-studio-appimages)](https://github.com/zyrouge/android-studio-appimages/releases/latest)
[![Latest (Pre-release)](https://img.shields.io/github/v/tag/zyrouge/android-studio-appimages?label=latest-nightly)](https://github.com/zyrouge/android-studio-appimages/releases)
[![Release](https://github.com/zyrouge/android-studio-appimages/actions/workflows/release.yml/badge.svg)](https://github.com/zyrouge/android-studio-appimages/actions/workflows/release.yml)

Packages [Android Studio Preview](https://developer.android.com/studio/preview) as AppImages.

AppImages are directly created from `.tar.gz` builds and are not decompiled or modified. AppImages are compiled in Ubuntu 20.04.

## Supported Builds

-   AMD64

## Installation

### Pho

This command requires [Pho](https://github.com/zyrouge/pho) to be installed.

```bash
# stable
pho install github --release prerelease --id android-studio zyrouge/android-studio-appimages

# beta
pho install github --id android-studio zyrouge/android-studio-appimages
```

### Manual

Can be directly downloaded from Github Releases and intergrated using tools like AppImageLauncher.
