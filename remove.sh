#!/bin/bash

echo "Remove running containers"
docker rm -f $(docker ps -a -q -f label=demo="quine-relay")
