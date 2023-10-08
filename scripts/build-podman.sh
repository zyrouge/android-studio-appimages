#!/bin/bash

set -eu

self=$(readlink -f "$0")
here=${self%/*}
root_dir=$(dirname "${here}")
dist_dir="${root_dir}/dist"

app_version=$1
container_name="android-studio-preview-appimage"
work_dir="/android-studio-preview-appimage"

podman run --rm -dti --name "${container_name}" ubuntu:20.04
podman wait --condition=running "${container_name}"
podman exec "${container_name}" apt update
podman exec "${container_name}" apt-get install -y curl desktop-file-utils
podman exec "${container_name}" mkdir "${work_dir}"
for x in "scripts" "templates"; do
    podman cp "./${x}" "${container_name}:${work_dir}/${x}"
done
podman exec "${container_name}" find "${work_dir}/scripts" -type f -name "*.sh" -exec chmod +x {} \;
podman exec "${container_name}" "${work_dir}/scripts/build.sh" "${app_version}"
podman cp "${container_name}:${work_dir}/dist" "${dist_dir}"
podman stop "${container_name}"

echo "Done!"
