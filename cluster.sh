#!/bin/bash

./remove.sh

# Bash strict mode
set -euo pipefail

# Run all nodes
LANGUAGES=($(jq -r .[].language steps.json))
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

	docker run -d --name="quine-$LANGUAGE" -e LANGUAGE="$LANGUAGE" $PORT $IMAGE
done

echo "Started."

./logs.sh
