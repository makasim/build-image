#!/usr/bin/env bash

set -x
set -e

[ -z "$1" ] && (echo "\$$1 is empty (distro)"; exit 1)
[ -z "$2" ] && (echo "\$$2 is empty (arch)"; exit 1)
[ -z "$GITHUB_SHA" ] && (echo "\$GITHUB_SHA is empty"; exit 1)
[ -z "$GITHUB_REF" ] && (echo "\$GITHUB_REF is empty"; exit 1)

DISTRO="$1"
ARCH="$2"

COMMIT_IMAGE="docker.io/makasim/build-image:$(printf '%s' "$GITHUB_SHA" | cut -c -8)-${DISTRO}-${ARCH}"
BRANCH_IMAGE="docker.io/makasim/build-image:${GITHUB_REF##*/}-${DISTRO}-${ARCH}"

./build.sh "${DISTRO}" "${ARCH}" "${COMMIT_IMAGE}"

docker tag "${COMMIT_IMAGE}" "${BRANCH_IMAGE}"
docker push "${COMMIT_IMAGE}"
docker push "${BRANCH_IMAGE}"

