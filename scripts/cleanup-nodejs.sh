#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

rm -Rf "${DIR}/app/web/themes/custom/droopler_subtheme/node_modules"
rm -Rf "${DIR}/app/web/themes/custom/droopler_subtheme/package-lock.json"
rm -Rf "${DIR}/app/web/profiles/contrib/droopler/themes/custom/droopler_theme/node_modules"
rm -Rf "${DIR}/app/web/profiles/contrib/droopler/themes/custom/droopler_theme/package-lock.json"