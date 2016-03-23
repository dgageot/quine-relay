#!/bin/bash

if [[ ! "${DOCKER_HOST}" =~ ^tcp://(.*):(.*)$ ]]; then
	DOCKER_IP="localhost"
else
  DOCKER_IP=${BASH_REMATCH[1]}
fi

set -x
curl --data-binary @test/QR.rb http://${DOCKER_IP}:8080/run
