#!/bin/bash
set -x
set -e

if ! [ -f vendor/bin/drush ]; then
  echo "vendor/bin/drush not found, init script not run"
  exit 0
fi

if [ -f /.droopler-init ]; then
  echo "/.droopler-init exists, droopler already initialized, skipping"
  exit 0
fi

vendor/bin/drush -y updb
vendor/bin/drush -y cr

touch /.droopler-init
