#!/bin/bash

set -eu

result="no"

if [ "${X_APP_RELEASE}" == "stable" ] && [ "${X_BUILD_STABLE}" != "false" ]; then
    result="yes"
fi

if [ "${X_APP_RELEASE}" == "beta" ] && [ "${X_BUILD_BETA}" != "false" ]; then
    result="yes"
fi

echo "${result}"
