#!/bin/bash

# Remove running containers
#
LANGUAGES=($(jq -r .[].language steps.json))

docker rm -f ${LANGUAGES[*]}

# Bash strict mode
#
set -euo pipefail

# Build the images
#
docker build -t quine/base .
for dockerfile in images/*.dockerfile; do
	filename=${dockerfile##*/}
	name=${filename%.*}
	docker build -t quine/$name -f $dockerfile .
done;

# Run all nodes
#
IMAGES=($(jq -r .[].image steps.json))
COUNT=${#LANGUAGES[@]}

for i in $(eval echo "{0..$(($COUNT - 1))}"); do
	LANGUAGE="${LANGUAGES[$i]}"
	IMAGE="${IMAGES[$i]}"

	PORT=""
	if [ "$i" == "0" ]; then
		PORT="-p 8080:8080"
	fi

	echo "Starting $LANGUAGE ($i/$COUNT)..."

	docker run -d --name="$LANGUAGE" -e LANGUAGE="$LANGUAGE" --net=quine $PORT $IMAGE
done

echo "Started."

# Show logs
#
./logs.sh ${CONTAINERS[*]}
