# Android Studio AppImages

[![Latest](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fzyrouge%2Fandroid-studio-appimages%2Fdist-badges%2Fbadge-latest.json)](https://github.com/zyrouge/android-studio-appimages/releases/latest)
[![Latest (Pre-release)](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fzyrouge%2Fandroid-studio-appimages%2Fdist-badges%2Fbadge-prerelease.json)](https://github.com/zyrouge/android-studio-appimages/releases)
[![Release](https://github.com/zyrouge/android-studio-appimages/actions/workflows/release.yml/badge.svg)](https://github.com/zyrouge/android-studio-appimages/actions/workflows/release.yml)
[![Badges](https://github.com/zyrouge/android-studio-appimages/actions/workflows/badges.yml/badge.svg)](https://github.com/zyrouge/android-studio-appimages/actions/workflows/badges.yml)

Packages [Android Studio](https://developer.android.com/studio) and [Android Studio Preview](https://developer.android.com/studio/preview) as AppImages.

AppImages are directly created from `.tar.gz` builds and are not decompiled or modified. AppImages are compiled in Ubuntu 20.04. Latest releases contain stable version and pre-releases contain beta version.

## Supported Builds

-   AMD64

## Installation

### Pho

This command requires [Pho](https://github.com/zyrouge/pho) to be installed.

```bash
# stable
pho install github --id android-studio zyrouge/android-studio-appimages

# beta
pho install github --release prerelease --id android-studio zyrouge/android-studio-appimages
```

### Manual

Can be directly downloaded from Github Releases and intergrated using tools like AppImageLauncher.
