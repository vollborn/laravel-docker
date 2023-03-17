#!/usr/bin/env bash

containerName="laravel"
phpVersion="8.2"

registryTag="test-host/laravel/laravel:latest"

docker build --file src/Dockerfile -t ${containerName} --build-arg PHP_VERSION=${phpVersion} .

docker image tag ${containerName}:latest ${registryTag}
docker image push ${registryTag}
