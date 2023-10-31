#!/bin/bash

set -eu

data=$(curl --fail -s https://developer.android.com/studio/preview)
data=$(echo "${data}" | awk '/data-category="beta_linux_bundle_download"/,/id="agree-button__beta_linux_bundle_download"/ { print }')
version=$(echo "${data}" | sed -nr 's/.*\/ide-zips\/(.*?)\/.*/\1/p')

echo "${version}"
