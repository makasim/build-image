#!/usr/bin/env bash

set -x
set -e

[ -z "$1" ] && (echo "\$$1 is empty (distro)"; exit 1)
[ -z "$2" ] && (echo "\$$2 is empty (arch)"; exit 1)
[ -z "$3" ] && (echo "\$$3 is empty (tag)"; exit 1)

DISTRO="$1"
ARCH="$2"
TAG="$3"

source ./.env

docker build \
    --build-arg "ALPINE_IMAGE=${ALPINE_IMAGE}" \
    --build-arg "GO_ALPINE_IMAGE=${GO_ALPINE_IMAGE}" \
    --build-arg "ALPINE_ARM64_IMAGE=${ALPINE_ARM64_IMAGE}" \
    --build-arg "GO_ALPINE_ARM64_IMAGE=${GO_ALPINE_ARM64_IMAGE}" \
    --build-arg "DEBIAN_IMAGE=${DEBIAN_IMAGE}" \
    --build-arg "GO_DEBIAN_IMAGE=${GO_DEBIAN_IMAGE}" \
    --build-arg "DEBIAN_ARM64_IMAGE=${DEBIAN_ARM64_IMAGE}" \
    --build-arg "GO_DEBIAN_ARM64_IMAGE=${GO_DEBIAN_ARM64_IMAGE}" \
    --build-arg "GOLANGCI_VERSION=${GOLANGCI_VERSION}" \
    --build-arg "GOVULNCHECKV=${GOVULNCHECKV}" \
    --build-arg "REFLEX_VERSION=${REFLEX_VERSION}" \
    --build-arg "STATICCHECK_VERSION=${STATICCHECK_VERSION}" \
    --build-arg "GOTEST_VERSION=${GOTEST_VERSION}" \
    --build-arg "DBMATE_VERSION=${DBMATE_VERSION}" \
    --build-arg "DOCKER_VERSION=${DOCKER_VERSION}" \
    --build-arg "DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION}" \
    --build-arg "TASK_VERSION=${TASK_VERSION}" \
    -f ${DISTRO}/${ARCH}/Dockerfile \
    -t "${TAG}" \
    --rm --pull --force-rm .