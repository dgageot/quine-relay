#!/bin/bash

LANGUAGES=($(jq -r .[].language steps.json))
CONTAINERS=($(jq -r .[].container steps.json))
COUNT=${#LANGUAGES[@]}

docker build -t quine .
for CONTAINER in ${CONTAINERS[@]}; do
	docker rm -f $CONTAINER
done

set -e

LAST_LANGUAGE="${LANGUAGES[$(($COUNT - 1))]}"
FIRST_LANGUAGE="${LANGUAGES[0]}"

PORT=""
for i in $(seq $(($COUNT-1)) -1 0); do
	LANGUAGE="${LANGUAGES[$i]}"
	CONTAINER="${CONTAINERS[$i]}"

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

	docker run -d --name=q-"$LANGUAGE" -e LANGUAGE="$LANGUAGE" $LINK $PORT quine
done

./logs.sh ${CONTAINERS[*]}
