#!/bin/bash 

if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set +e
set -x

echo "${BASE_CMD_RUN}"

MYDIR="$(dirname "$(realpath "$0")")"
cd "$MYDIR"

if grep -q D_ENV=test ".env"; then
  echo "D_ENV config OK, proceeding..."
else
  echo "D_ENV config fail, please set D_ENV=test"
  exit;
fi

${BASE_CMD_RUN} codecept codecept clean
${BASE_CMD_RUN} codecept codecept run visual --env desktop --debug --html --xml 

NOW="desktop"
BACKUP_DIR="$MYDIR/../tests/tests/reports.$(date +'%m-%d-%Y_%H-%M')"
BACKUP_DIR_TIME="$BACKUP_DIR/$NOW"
REPORTS_DIR="$MYDIR/../tests/tests/_output"

echo "Backing up report data to ./$BACKUP_DIR directory, please wait..."

if [ "$(ls -A $REPORTS_DIR)" ]; then
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  mkdir "$BACKUP_DIR_TIME"
  cp -r "$REPORTS_DIR"/* "$BACKUP_DIR_TIME"
fi

${BASE_CMD_RUN} codecept codecept clean
${BASE_CMD_RUN} codecept codecept run visual --env tablet --debug --html --xml 

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

${BASE_CMD_RUN} codecept codecept clean
${BASE_CMD_RUN} codecept codecept run visual --env mobile --debug --html --xml 

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
