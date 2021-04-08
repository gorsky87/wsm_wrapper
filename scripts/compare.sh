#!/bin/bash 
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set +e
set -x

echo "${BASE_CMD_RUN}"

prnt "Rebuild sitemap: ${BASE_CMD_RUN} php-dev drush --uri=droopler.localhost simple-sitemap-generate"
${BASE_CMD_RUN} php-dev drush --uri=${D_HOST} simple-sitemap-generate

MYDIR="$(dirname "$(realpath "$0")")"
cd "$MYDIR"

if grep -q D_ENV=test ".env"; then
  echo "D_ENV config OK, proceeding..."
else
  echo "D_ENV config fail, please set D_ENV=test"
  exit;
fi
BACKUP_DIR="$MYDIR/../tests/tests/reports.$(date +'%m-%d-%Y_%H-%M')"
VISUAL_BACKUP_DIR="$BACKUP_DIR/VisualCeption/"
VISUAL_DATA_DIR="$MYDIR/../tests/tests/_data/VisualCeption"
REPORTS_DIR="$MYDIR/../tests/tests/_output"
sudo rm -Rf  "$VISUAL_DATA_DIR"

${BASE_CMD_RUN} codecept codecept clean
${BASE_CMD_RUN} codecept codecept run compare --env desktop --html --xml --debug

NOW="desktop"
BACKUP_DIR_TIME="$BACKUP_DIR/$NOW"

echo "Backing up report data to ./$BACKUP_DIR directory, please wait..."

if [ "$(ls -A $REPORTS_DIR)" ]; then
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  mkdir "$BACKUP_DIR_TIME"
  cp -r "$REPORTS_DIR"/* "$BACKUP_DIR_TIME"
fi

${BASE_CMD_RUN} codecept codecept clean
${BASE_CMD_RUN} codecept codecept run compare --env tablet --html --xml --debug

NOW="tablet"

BACKUP_DIR_TIME="$BACKUP_DIR/$NOW"


echo "Backing up report data to ./$BACKUP_DIR directory, please wait..."

if [ "$(ls -A $REPORTS_DIR)" ]; then
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  mkdir "$BACKUP_DIR_TIME"
  cp -r "$REPORTS_DIR"/* "$BACKUP_DIR_TIME"
fi

${BASE_CMD_RUN} --rm codecept codecept clean
${BASE_CMD_RUN} codecept codecept run compare --env mobile --html --xml --debug

NOW="mobile"

BACKUP_DIR_TIME="$BACKUP_DIR/$NOW"


echo "Backing up report data to ./$BACKUP_DIR directory, please wait..."

if [ "$(ls -A $REPORTS_DIR)" ]; then
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  mkdir "$BACKUP_DIR_TIME"
  cp -r "$REPORTS_DIR"/* "$BACKUP_DIR_TIME"
fi

mkdir "$VISUAL_BACKUP_DIR"
cp -Rf "$VISUAL_DATA_DIR"/* "$VISUAL_BACKUP_DIR"

