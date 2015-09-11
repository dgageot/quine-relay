#!/bin/bash

# Remove running containers
#
CONTAINERS=($(jq -r .[].container steps.json))

docker rm -f ${CONTAINERS[*]}

# Bash strict mode
#
set -euo pipefail

# Build the images
#
docker build -t quine -f images/Dockerfile .
# ...

# Run all nodes
#
LANGUAGES=($(jq -r .[].language steps.json))
IMAGES=($(jq -r .[].image steps.json))
COUNT=${#LANGUAGES[@]}
LAST_LANGUAGE="${LANGUAGES[$(($COUNT - 1))]}"
FIRST_LANGUAGE="${LANGUAGES[0]}"

PORT=""
for i in $(seq $(($COUNT-1)) -1 0); do
	LANGUAGE="${LANGUAGES[$i]}"
	CONTAINER="${CONTAINERS[$i]}"
	IMAGE="${IMAGES[$i]}"

	echo "Starting $CONTAINER for $LANGUAGE ($i/$COUNT)..."

	if [ "$LAST_LANGUAGE" == "$LANGUAGE" ]; then
		LINK=""
	else
		NEXT_LANGUAGE="${LANGUAGES[$(($i + 1))]}"
		LINK="--link=q-${NEXT_LANGUAGE}:next"
	fi

	if [ "$FIRST_LANGUAGE" == "$LANGUAGE" ]; then
		PORT="-p 8080:8080"
	else
		PORT=""
	fi

	docker run -d --name=q-"$LANGUAGE" -e LANGUAGE="$LANGUAGE" $LINK $PORT $IMAGE
done

# Show logs
#
./logs.sh ${CONTAINERS[*]}
