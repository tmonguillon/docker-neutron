#!/bin/bash
set -x

# Init Neutron vars
NEUTRON_USER_NAME=${NEUTRON_USER_NAME:-neutron}
NEUTRON_PASSWORD=${NEUTRON_PASSWORD:-NEUTRON_DBPASS}
NEUTRON_HOST=${NEUTRON_HOST:-$HOSTNAME}

NEUTRON_CONFIG_FILE=/etc/neutron/neutron.conf
ML2_CONFIG_FILE=/etc/neutron/plugins/ml2/ml2_conf.ini

SQL_SCRIPT=${SQL_SCRIPT:-/opt/neutron.sql}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
until mysql -uroot -p$MYSQL_ROOT_PASSWORD -h$MYSQL_HOST -e 'select 1'; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 3
done
mysql -uroot -p$MYSQL_ROOT_PASSWORD -h$MYSQL_HOST <$SQL_SCRIPT


neutron-db-manage \
  --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini \
  upgrade head


neutron-db-manage \
  --subproject networking-sfc \
  upgrade head

/usr/bin/ovs-vsctl emer-reset
sed -i "s#^local_ip.*=.*#local_ip = ${LOCAL_IP}#" $ML2_CONFIG_FILE
/usr/bin/supervisord
