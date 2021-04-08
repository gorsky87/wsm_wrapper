#!/bin/sh
# if variable $SETUID is not set - use our default UID for httrack
SETUID=${SETUID:-7000}

if [ ${DEBUG_IMAGE:-0} -gt 0 ]; then
    # Notify user about the UID selected
    echo "Current SETUID : ${SETUID}"
fi

# Create dedicated user with specified UID
adduser -u "${SETUID}" -H -D  httrack

# Execute process
exec gosu httrack "$@"
