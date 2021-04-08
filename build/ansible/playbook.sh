#!/bin/bash
#
# This script is used to forward .env variables to Ansible
#
set -o nounset -o pipefail -o errexit

# Load all variables from .env and export them all for Ansible to read
set -o allexport
source "/app/build/.env"
set +o allexport

# Run Ansible
exec ansible-playbook "$@"
