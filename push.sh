#!/bin/bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Build the base image
docker build -t dgageot/quine:base .
docker push dgageot/quine:base

LANGUAGES=($(jq -r .[].language steps.json))
IMAGES=($(jq -r .[].image steps.json))
COUNT=${#LANGUAGES[@]}

cd test
for i in $(seq 0 1 $(($COUNT-1))); do
	LANGUAGE="${LANGUAGES[$i]}"
	IMAGE="${IMAGES[$i]}"

	docker build -t $IMAGE -f ../images/$LANGUAGE.dockerfile ..
	docker push $IMAGE
done
