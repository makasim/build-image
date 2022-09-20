#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "service host: first argument must be provided"
fi

if [ -z "$2" ]
  then
    echo "service port: second argument must be provided"
fi

echo "Wait for services"

FORCE_EXIT=false
trap "FORCE_EXIT=true" SIGTERM SIGINT

MAX_ATTEMPTS=${3:-30}
ATTEMPTS=0
until nc -z "$1" "$2"; do
    printf "wait for service %s:%s\n" "$1" "$2"
    ((ATTEMPTS++))
    if [ "$ATTEMPTS" -ge "$MAX_ATTEMPTS" ]; then
        printf "service is not running %s:%s\n" "$1" "$2"
        exit 1
    fi
    if [ "$FORCE_EXIT" = true ]; then
        exit;
    fi

    sleep 1
done

printf "service is online %s:%s\n" "$1" "$2"
