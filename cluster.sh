#!/bin/bash

./remove.sh

# Bash strict mode
set -euo pipefail

# Run all nodes
LANGUAGES=($(jq -r .[].language steps.json))
IMAGES=($(jq -r .[].image steps.json))
COUNT=${#LANGUAGES[@]}

PORT=8080
for i in $(eval echo "{0..$(($COUNT - 1))}"); do
	LANGUAGE="${LANGUAGES[$i]}"
	IMAGE="${IMAGES[$i]}"

	echo "Starting $LANGUAGE ($i/$COUNT) on port $PORT..."
	docker run -d --name="quine-$LANGUAGE" -e LANGUAGE="$LANGUAGE" -p $PORT:8080 --net quine $IMAGE

	PORT=$((PORT + 1))
done

echo "Started."

./logs.sh
