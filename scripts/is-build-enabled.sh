#!/bin/bash

set -eu

result="no"

if [ "${X_APP_RELEASE}" == "stable" ] && [ "${X_BUILD_STABLE}" == "true" ]; then
    result="yes"
fi

if [ "${X_APP_RELEASE}" == "beta" ] && [ "${X_BUILD_BETA}" == "true" ]; then
    result="yes"
fi

echo "${result}"
