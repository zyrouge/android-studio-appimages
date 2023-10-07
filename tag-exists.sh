#!/bin/bash

if ! [ -n "$1" ]; then
    echo "error: Missing version argument"
    exit 1
fi

tag=$1
output=$(git ls-remote --exit-code --tags origin "$tag")

if [ "$output" == "" ]; then
    echo "no"
else
    echo "yes"
fi
