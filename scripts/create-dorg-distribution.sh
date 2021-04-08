#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

cd "${DIR}"

# Clean assets
./${EXEC_CMD} npm-theme install
./${EXEC_CMD} gulp-theme clean
./${EXEC_CMD} gulp-theme dist --profile_url=/profiles/droopler


# Copy libs
cd app/web/profiles/contrib/droopler
rm -Rf libraries
mkdir libraries
cp -Rf ../../../libraries/colorbox libraries/colorbox
cp -Rf ../../../libraries/countup libraries/countup
cp -Rf ../../../libraries/in-viewport libraries/in-viewport
cp -Rf ../../../libraries/masonry libraries/masonry
cp -Rf ../../../libraries/select2 libraries/select2
cp -Rf ../../../libraries/slick-carousel libraries/slick-carousel
cp -Rf ../../../libraries/object-fit-images libraries/object-fit-images
cp -Rf ../../../libraries/lazysizes libraries/lazysizes

# Replace paths
grep -rl '/profiles/contrib/droopler' . | xargs sed -i 's|/profiles/contrib/droopler|/profiles/droopler|g'

# Remove some stuff from gitignores
sed -i '/libraries/d' .gitignore
sed -i '/css\/\*/d' themes/custom/droopler_theme/.gitignore
sed -i '/!css\/README/d' themes/custom/droopler_theme/.gitignore
sed -i '/js\/min\/\*/d' themes/custom/droopler_theme/.gitignore
sed -i '/js\/vendor\/\*/d' themes/custom/droopler_theme/.gitignore
sed -i '/!js\/min\/README/d' themes/custom/droopler_theme/.gitignore
sed -i '/package-lock.json/d' themes/custom/droopler_theme/.gitignore
