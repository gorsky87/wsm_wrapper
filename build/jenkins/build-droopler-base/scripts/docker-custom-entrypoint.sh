#!/usr/bin/env bash
set -e

if [ ${DEBUG_IMAGE:-0} -gt 0 ]; then
    set -x
fi

if ! [ $(id -u) = 0 ]; then
    # Exit script if not root
    exec "$@"
    return 0
fi

init_dedicated_user() {

    # if variable $SETUID is not set - use our default UID for dropadmin
    SETUID=${SETUID:-7000}

    if [ ${DEBUG_IMAGE:-0} -gt 0 ]; then
        # Notify user about the UID selected
        echo "Current SETUID : ${SETUID}"
    fi

    # Create dedicated user with specified UID
    useradd -u "${SETUID}" -s /bin/false -d /home/dropadmin -m -G sudo -c "Droptica dedicated www user" dropadmin || echo 'user exists'

    # Set "HOME" ENV variable for user's home directory
    export HOME=/home/dropadmin
    export APACHE_RUN_USER=dropadmin
    export APACHE_RUN_GROUP=dropadmin
}

init_xdebug() {

    if [[ ${XDEBUG_ENABLE:-0} -gt 0 ]]; then
        echo "XDEBUG_ENABLE: ${XDEBUG_ENABLE}"
        docker-php-ext-enable xdebug
        cp "${PHP_INI_DIR}/conf.d/php-xdebug.ini.dist" "${PHP_INI_DIR}/conf.d/z-xdebug.ini"
    fi
}

init_newrelic() {

    if [[ ! -z ${NR_INSTALL_KEY+x} && ! -e ~/.new_relic_enabled ]]; then
        touch ~/.new_relic_enabled
        export NR_INSTALL_SILENT=1
        export NR_INSTALL_PHPLIST=/usr/local/bin
        curl "http://download.newrelic.com/php_agent/archive/${NEW_RELIC_VERSION}/newrelic-php5-${NEW_RELIC_VERSION}-linux.tar.gz" |  tar xzC /root
        /root/newrelic-php5-${NEW_RELIC_VERSION}-linux/newrelic-install install
        mkdir -p /var/log/newrelic /var/run/newrelic
        cp "/etc/newrelic/newrelic.cfg.template" "/etc/newrelic/newrelic.cfg"
        cp "${PHP_INI_DIR}/conf.d/php-newrelic.ini.dist" "${PHP_INI_DIR}/conf.d/z-newrelic.ini"
        newrelic-daemon -c /etc/newrelic/newrelic.cfg --pidfile /var/run/newrelic-daemon.pid
    fi
}

init_blackfire() {

    if [[ ${BLACKFIRE_ENABLE:-0} -gt 0 ]]; then
        cp "${PHP_INI_DIR}/conf.d/php-blackfire.ini.dist" "${PHP_INI_DIR}/conf.d/z-blackfire.ini"
    fi
}

# Allow user to run additional commands during container start
init_additional_cmds() {

  echo "Looking for additional scripts to run in /usr/local/bin/docker-additional-cmds..."
  if [ -d "/usr/local/bin/docker-additional-cmds" ]; then
    for file in /usr/local/bin/docker-additional-cmds/*.sh
    do
      echo "Running additional file: ${file}"
      bash "${file}"
    done
  fi
  echo "Additional scripts run finished"
}

# Run init functions
init_dedicated_user
#init_xdebug
#init_newrelic
#init_blackfire
init_additional_cmds

if [ "${WEB_USER}" ] && [ "${WEB_PASS}" ]; then
    printf "${WEB_USER}:`openssl passwd -apr1 ${WEB_PASS}`\n" >> /etc/apache2/.htpasswd
    a2enconf htpasswd.conf
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"
