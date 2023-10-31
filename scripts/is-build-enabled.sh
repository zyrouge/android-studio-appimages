#!/bin/bash

if [ "${X_APP_RELEASE}" == "stable" ] && [ "${X_BUILD_STABLE}" == "true" ]; then
    echo "yes"
fi

if [ "${X_APP_RELEASE}" == "beta" ] && [ "${X_BUILD_BETA}" == "true" ]; then
    echo "yes"
fi

echo "no"
