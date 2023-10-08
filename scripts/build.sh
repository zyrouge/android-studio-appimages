#!/bin/bash

set -eu

curl_ua="Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/118.0"

self=$(readlink -f "$0")
here=${self%/*}
root_dir=$(dirname "${here}")
templates_dir="${root_dir}/templates"
artifacts_dir="${root_dir}/artifacts"
dist_dir="${root_dir}/dist"

app_version=$1
echo "Android Studio Version: ${app_version}"

app_title="Android Studio"
app_name="android-studio"

appimagetool_path="${artifacts_dir}/appimagetool.AppImage"
appimagetool_app_dir="${artifacts_dir}/appimagetool.AppDir"
appimagetool="${appimagetool_app_dir}/AppRun"
appimagetool_url="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"

mkdir -p "${artifacts_dir}"
if ! [ -f "${appimagetool_path}" ]; then
    echo "Downloading ${appimagetool_url}"
    curl -Ls -A "${curl_ua}" "${appimagetool_url}" -o "${appimagetool_path}"
    echo "Downloaded ${appimagetool_path}"
else
    echo "Skipping AppImageTool..."
fi
if ! [ -d "${appimagetool_app_dir}" ]; then
    echo "Extracting ${appimagetool_path}"
    cd "${artifacts_dir}"
    "${appimagetool_path}" --appimage-extract
    mv ./squashfs-root "${appimagetool_app_dir}"
    cd ..
    echo "Created ${appimagetool_app_dir}"
else
    echo "Skipping extracting ${appimagetool_path}"
fi

app_dir="${artifacts_dir}/${app_name}.AppDir"
archive_file="${artifacts_dir}/android-studio-${app_version}-linux.tar.gz"
download_url="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${app_version}/android-studio-${app_version}-linux.tar.gz"

if ! [ -d "${app_dir}" ]; then
    if ! [ -f "${archive_file}" ]; then
        echo "Downloading ${download_url}"
        curl -Ls -A "${curl_ua}" "${download_url}" -o "${archive_file}"
        echo "Downloaded ${archive_file}"
    else
        echo "Skipping download..."
    fi

    echo "Extracting ${archive_file}"
    tar -xf "${archive_file}" "android-studio"
    mv "android-studio" "${app_dir}"
    echo "Created ${app_dir}"
else
    echo "Skipping AppDir creation..."
fi

d_icon="${app_dir}/bin/studio.png"
d_icon_vector="${app_dir}/bin/studio.svg"

cp "${d_icon}" "${app_dir}/${app_name}.png"
cp "${d_icon_vector}" "${app_dir}/${app_name}.svg"
convert "${d_icon}" -resize 256x256 "${app_dir}/.DirIcon"
for x in "256x256" "512x512" "1024x1024"; do
    icon_dir="${app_dir}/usr/share/icons/hicolor/${x}/apps"
    mkdir -p "${icon_dir}"
    convert "${d_icon}" -resize "${x}" "${icon_dir}/${app_name}.png"
done
desktop_content=$(cat "${templates_dir}/${app_name}.desktop")
desktop_content="${desktop_content//@@TITLE@@/${app_title}}"
desktop_content="${desktop_content//@@NAME@@/${app_name}}"
echo "${desktop_content}" >"${app_dir}/${app_name}.desktop"
cp "${templates_dir}/AppRun" "${app_dir}/AppRun"
echo "Initialized ${app_dir}"

appimage_arch="x86_64"
appimage_file="${dist_dir}/${app_name}-${app_version}-${appimage_arch}.AppImage"

echo "Building ${app_dir}"
mkdir -p "${dist_dir}"
ARCH=$appimage_arch "${appimagetool}" "${app_dir}" "${appimage_file}"
chmod +x "${appimage_file}"
echo "Created ${appimage_file}"
