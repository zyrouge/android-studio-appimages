#!/bin/bash

set -eu

self=$(readlink -f "$0")
here=${self%/*}

app_version=$1
echo "Android Studio Version: ${app_version}"

app_title="Android Studio"
app_name="android-studio"
app_dir="${here}/${app_name}.AppDir"
tag_name="v${app_version}"
appimage_arch="x86_64"
appimage_file="${here}/${app_name}-${app_version}-${appimage_arch}.AppDir"

appimage_tool="${here}/appimagetool.AppImage"
appimage_tool_url="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"

if ! [ -f $appimage_tool ]; then
    echo "Downloading ${appimage_tool_url}"
    curl -L "${appimage_tool_url}" -o "${appimage_tool}"
    echo "Downloaded ${appimage_tool}"
else
    echo "Skipping AppImageTool..."
fi

archive_file="${here}/android-studio.tar.gz"
download_url="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${app_version}/android-studio-${app_version}-linux.tar.gz"

if ! [ -d $app_dir ]; then
    if ! [ -f $archive_file ]; then
        echo "Downloading ${download_url}"
        curl -L "${download_url}" -o "${archive_file}"
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

# prepare AppDir
cp "${d_icon}" "${app_dir}/${app_name}.png"
cp "${d_icon_vector}" "${app_dir}/${app_name}.svg"
convert "${d_icon}" -resize 256x256 "${app_dir}/.DirIcon"
for x in "256x256" "512x512" "1024x1024"; do
    icon_dir="${app_dir}/usr/share/icons/hicolor/${x}/apps"
    mkdir -p "${icon_dir}"
    convert "${d_icon}" -resize "${x}" "${icon_dir}/${app_name}.png"
done
desktop=$(cat "${here}/${app_name}.desktop")
desktop=$(echo "${desktop}" | sed "s/@@TITLE@@/${app_title}/")
desktop=$(echo "${desktop}" | sed "s/@@NAME@@/${app_name}/")
echo "${desktop}" > "${app_dir}/${app_name}.desktop"
cp "${here}/AppRun" "${app_dir}/AppRun"
echo "Initialized ${app_dir}"

echo "Building ${app_dir}"
ARCH=$appimage_arch ./appimagetool.AppImage "${app_dir}" "${appimage_file}"
echo "Created ${appimage_file}"
