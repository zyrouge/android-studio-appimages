#!/bin/bash

set -u

tag=$1
git ls-remote --exit-code --tags origin $tag
status=$?
if [ $status == 0 ]; then
    echo "yes"
else
    echo "no"
fi
