#!/bin/sh
docker run -i --rm -v "C:/Projects/USD/usd_from_gilf_docker/docker-gltf-to-udsz":/usr/app leon/usd-from-gltf:latest "$@" "${@%.*}.usdz"