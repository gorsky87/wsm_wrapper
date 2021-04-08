#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x
cd "${DIR}"
if [[ ! -f "app/vendor/bin/drupal-check" ]]; then
  ./${EXEC_CMD} run composer require mglaman/drupal-check --dev
else
  echo "Already exists"
fi

if [[ ! -d "${DIR}/app/web/modules/contrib" ]]; then
  mkdir -p "${DIR}/app/web/modules/contrib"
fi

cd "${DIR}/app/web/modules/contrib"
rm -rf $1
git clone https://git.drupalcode.org/project/${1}.git

if [[ ! -z ${2+x} ]]; then
  echo "Download patch: $2"
  cd "${DIR}/app/web/modules/contrib/${1}"
  wget $2
  git apply `basename $2`
fi


cd "${DIR}"
./${EXEC_CMD} run drupal-check -d web/modules/contrib/$1

echo "Check https://www.drupal.org/project/issues/${1}?categories=All"
