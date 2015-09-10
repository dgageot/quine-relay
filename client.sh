#!/bin/bash

if [[ ! "${DOCKER_HOST}" =~ ^tcp://(.*):(.*)$ ]]; then
	DOCKER_IP="localhost"
else
  DOCKER_IP=${BASH_REMATCH[1]}
fi

echo "curl --data-binary @QR.rb http://${DOCKER_IP}:8080/run/ruby"
curl --data-binary @QR.rb http://${DOCKER_IP}:8080/run/ruby
