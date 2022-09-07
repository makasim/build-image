#!/usr/bin/env bash

set -x
set -e

[ -z "$GITHUB_SHA" ] && (echo "\$GITHUB_SHA is empty"; exit 1)

BUILD_IMAGE_VERSION="$(printf '%s' "$GITHUB_SHA" | cut -c -8)-debian-amd64"

./build.sh "debian/amd64/Dockerfile" "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}"

docker tag "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}" "docker.io/makasim/build-image:${GITHUB_REF##*/}"
docker push "docker.io/makasim/build-image:${BUILD_IMAGE_VERSION}"
docker push "docker.io/makasim/build-image:${GITHUB_REF##*/}"

COMMIT_IMAGE="docker.io/makasim/build-image:$(printf '%s' "$GITHUB_SHA" | cut -c -8)-debian-amd64"
BRANCH_IMAGE="docker.io/makasim/build-image:${GITHUB_REF##*/}-debian-amd64"

./build.sh "debian/amd64/Dockerfile" "${COMMIT_IMAGE}"

docker tag "${COMMIT_IMAGE}" "${BRANCH_IMAGE}"
docker push "docker.io/makasim/build-image:${COMMIT_IMAGE}"
docker push "docker.io/makasim/build-image:${BRANCH_IMAGE}"