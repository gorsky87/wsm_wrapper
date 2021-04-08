#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./${EXEC_CMD}:";
  echo "./${EXEC_CMD} ${me%.*}"
fi
set -e
set -x

cd "${DIR}/app"

git clean -fdx
git checkout -- .

cd "${DIR}"
./${EXEC_CMD} run composer install
./${EXEC_CMD} run composer d:s

./${EXEC_CMD} npm-theme install
./${EXEC_CMD} gulp-theme clean
./${EXEC_CMD} gulp-theme dist

./${EXEC_CMD} npm-subtheme install
./${EXEC_CMD} gulp-subtheme clean
./${EXEC_CMD} gulp-subtheme dist

rm -Rf "${DIR}/app/web/themes/custom/droopler_subtheme/node_modules"
rm -Rf "${DIR}/app/web/profiles/contrib/droopler/themes/custom/droopler_theme/node_modules"

if [[ -z $1 ]]; then
  NAME=droopler
else
  NAME="droopler-${1}"
fi

find ./app -type d -name .git -exec rm -Rf {} \; || :

rm -f "${DIR}/${NAME}.tar.gz"
cd "${DIR}/app" && tar -zcf "${DIR}/${NAME}.tar.gz" .

rm -f "${DIR}/${NAME}.zip"
cd "${DIR}/app" && zip -q -r9 "${DIR}/${NAME}.zip" .