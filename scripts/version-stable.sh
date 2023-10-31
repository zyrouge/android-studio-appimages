#!/bin/bash

set -eu

data=$(curl -s https://developer.android.com/studio)
data=$(echo "${data}" | awk '/data-category="studio_linux_bundle_download"/,/id="agree-button__studio_linux_bundle_download"/ { print }')
version=$(echo "${data}" | sed -nr 's/.*\/ide-zips\/(.*?)\/.*/\1/p')

echo "${version}"
