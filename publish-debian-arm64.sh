#!/usr/bin/env sh

set -x
set -e

[ -z "$GITHUB_SHA" ] && (echo "\$GITHUB_SHA is empty"; exit 1)

BUILD_IMAGE_VERSION="$(printf '%s' "$GITHUB_SHA" | cut -c -8)-debian-arm64"

./build.sh "debian/amd64/Dockerfile" "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}"

docker push "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}"