#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

${BASE_CMD_RUN} httrack

for f in $(find ../httrack/${D_HOST} -name "*.html" -type f); do
	if [[ $f = *"/index.html" ]]; then
		echo "Omitting $f"
	else
		echo "Processing $f"
		mkdir -p "${f%.html}"
		mv $f "${f%.html}/index.html"
	fi
done
