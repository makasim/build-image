#!/usr/bin/env bash

set -x
set -e

[ -z "$GITHUB_SHA" ] && (echo "\$GITHUB_SHA is empty"; exit 1)
[ -z "$GITHUB_REF" ] && (echo "\$GITHUB_REF is empty"; exit 1)

BUILD_IMAGE_VERSION="$(printf '%s' "$GITHUB_SHA" | cut -c -8)-alpine-amd64"

./build.sh "alpine/amd64/Dockerfile" "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}"

docker tag "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}" "docker.io/makasim/build-image:${GITHUB_REF##*/}"
docker push "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}"
docker push "docker.io/makasim/build-image:${GITHUB_REF##*/}"

