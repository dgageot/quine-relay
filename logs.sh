#!/bin/bash

function killJobs() {
	JOBS=$(jobs -p)
	if [ -n "${JOBS}" ]; then
		kill ${JOBS}
	fi
}

trap killJobs EXIT

for NAME in "$@"; do
	docker logs -f ${NAME} &
done

wait