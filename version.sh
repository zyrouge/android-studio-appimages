#!/bin/bash

set -eu

page=$(curl -s https://developer.android.com/studio/preview)
filename=$(echo "$page" | grep -m 1 "linux.tar.gz")
version=$(echo "$filename" | sed -nr 's/.*android-studio-(.*?)-linux\.tar\.gz.*/\1/p')

echo "$version"
