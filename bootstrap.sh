#!/bin/bash
set -x

# Init Neutron vars
NEUTRON_USER_NAME=${NEUTRON_USER_NAME:-neutron}
NEUTRON_PASSWORD=${NEUTRON_PASSWORD:-NEUTRON_PASS}
NEUTRON_HOST=${NEUTRON_HOST:-$HOSTNAME}

NEUTRON_CONFIG_FILE=/etc/neutron/neutron.conf
ML2_CONFIG_FILE=/etc/neutron/plugins/ml2/ml2_conf.ini

