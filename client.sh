#!/bin/bash

# if [[ ! "${DOCKER_HOST}" =~ ^tcp://(.*):(.*)$ ]]; then
# 	DOCKER_IP="localhost"
# else
#   DOCKER_IP=${BASH_REMATCH[1]}
# fi

DOCKER_IP=$(docker port quine-ruby 8080)

set -x
curl --data-binary @test/QR.rb http://${DOCKER_IP}/run
