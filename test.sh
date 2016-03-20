#!/bin/bash

CONTAINERS=($(jq -r .[].container steps.json))

# Bash strict mode
#
set -euo pipefail
IFS=$'\n\t'

# Build the images
#
docker build -t quine/base .
for dockerfile in images/*.dockerfile; do
	filename=${dockerfile##*/}
	name=${filename%.*}
	docker build -t quine/$name -f $dockerfile .
done;

LANGUAGES=($(jq -r .[].language steps.json))
IMAGES=($(jq -r .[].image steps.json))
COMMANDS=($(jq -r .[].command steps.json))
FROMS=($(jq -r .[].from steps.json))
TOS=($(jq -r .[].to steps.json))
COUNT=${#LANGUAGES[@]}

cd test
for i in $(seq 0 1 $(($COUNT-1))); do
	LANGUAGE="${LANGUAGES[$i]}"
	CONTAINER="${CONTAINERS[$i]}"
	IMAGE="${IMAGES[$i]}"
	COMMAND="${COMMANDS[$i]}"
	FROM="${FROMS[$i]}"
	TO="${TOS[$i]}"

	echo "Run $i $LANGUAGE..."
	docker run --rm -ti -v $(pwd)/$FROM:/root/go/src/github.com/dgageot/quine-relay/$FROM:ro -v $(pwd):/output $IMAGE bash -c "$COMMAND && cp $TO /output/$TO"
done

diff QR.rb QR2.rb && echo "SUCCESS"
