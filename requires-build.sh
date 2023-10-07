#!/bin/bash

curl_ua="Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/118.0"

if ! [ -n "$1" ]; then
    echo "error: Missing tag name argument"
    exit 1
fi

tag_name=$1
repo="zyrouge/android-studio-preview-appimage"

api_url="https://api.github.com/repos/${repo}/releases/tags/${tag_name}"
data=$(curl -s -A "${curl_ua}" "${api_url}")
appimages_count=$(echo "${data}" | grep -c '.AppImage"')
requires_build="no"

if [ "$appimages_count" == "0" ]; then
    requires_build="yes"
fi

echo "${requires_build}"
