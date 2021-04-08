# Checkout sources

Put your project in `./app` directory, so the path to `index.php` is `./app/web/index.php`. Download GIT submodules:

    git submodule update --init --recursive

Make sure the `.env` file is set (change the domain inside it if you like) and all docker images are up-to-date and running:
    
    cp ./build/.env.dev ./build/.env
    ./exec.sh pull
    ./exec.sh up -d

# Build profile without the database

    ./exec.sh build-profile
    
# Build project from existing database and files

    ./exec.sh build-site
    
# Build project from a drupal.org package

Create a `./app/web` directory. Extract all the code from the `tar.gz` file from https://www.drupal.org/project/droopler into it.

You don't need DB or files, just run this command:

    ./exec.sh build-dorg

The difference between standard build is turning off Composer and Gulp.

# Create drupal.org package

This script clones the https://www.drupal.org/project/droopler repository into 
the new `distribution` directory of the wrapper and copies new Droopler files over it.
The SCSS/JS are compiled and all paths are changed to work with `drush make`. 
The database or working installation is not needed to perform the creation.

Please carefully review all changes before pushing them to drupal.org repository.

    ./build/create-dorg-distribution.sh

# Theming
## Base theming commands

To work with npm and Gulp in`droopler_theme` use the following commands:

    ./exec.sh npm-theme <command>
    ./exec.sh gulp-theme <command>
    
In `droopler_subtheme` use:

    ./exec.sh npm-subtheme <command>
    ./exec.sh gulp-subtheme <command>
    
The SCSS assumes the assets are inside the `web/profiles/contrib/droopler/themes/custom/droopler_theme` 
directory. If you want to change this dir, compile the `droopler_theme` with additional option:

    ./exec.sh gulp-theme compile --profile_url=/profiles/other_dir/droopler
    ./exec.sh gulp-theme dist --profile_url=/profiles/other_dir/droopler
    
## Basic theming workflow

To start using Gulp, run:

    ./exec.sh npm-theme install
    ./exec.sh npm-subtheme install
    ./exec.sh gulp-theme compile
    ./exec.sh gulp-subtheme compile
    
## Available Gulp commands

* `compile` - compiles **dev** version of CSS/JS.
* `dist` - compiles **prod** version of CSS/JS.
* `debug` - shows debug info to troubleshoot problems.
* `clean` - removes all compiled assets.
* `watch` - watches for changes in SCSS and JS, remember to watch both theme and subtheme!

## Theming troubleshooting

In case of problems with GULP run the following commands to reset nodejs:

    ./exec.sh pull
    ./exec.sh cleanup-nodejs

# Other dev commands
    
* `./exec.sh run drush <command>` - runs Drush command.
* `./exec.sh run drupal <command>` - runs Drupal Console command.
* `./exec.sh run <command>` - runs a command in php-dev container.
* `./exec.sh run-in <container> <command>` - runs a command in a specified container.
* `./exec.sh cleanup-nodejs` - removes `node_modules` and directory `package-lock.json` file for both droopler_theme and droopler_subtheme.
* `./exec.sh cleanup-ignored` - removes all files from /app ignored by GIT.
* `./exec.sh prepare` - builds the code (composer + gulp) without touching DB.

    
Examples:

    ./exec.sh run drush uli
    ./exec.sh run drupal site:status
    ./exec.sh run composer install -vvv

## Httrack

* Uncoment httract in docker-compose.dev.yml
* run `./exec.sh httrack`