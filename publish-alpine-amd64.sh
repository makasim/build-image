#!/usr/bin/env bash

set -x
set -e

[ -z "$GITHUB_SHA" ] && (echo "\$GITHUB_SHA is empty"; exit 1)
[ -z "$GITHUB_REF" ] && (echo "\$GITHUB_REF is empty"; exit 1)

COMMIT_IMAGE="docker.io/makasim/build-image:$(printf '%s' "$GITHUB_SHA" | cut -c -8)-alpine-amd64"
BRANCH_IMAGE="docker.io/makasim/build-image:${GITHUB_REF##*/}-alpine-amd64"

./build.sh "alpine/amd64/Dockerfile" "${COMMIT_IMAGE}"

docker tag "${COMMIT_IMAGE}" "${BRANCH_IMAGE}"
docker push "docker.io/makasim/build-image:${COMMIT_IMAGE}"
docker push "docker.io/makasim/build-image:${BRANCH_IMAGE}"

