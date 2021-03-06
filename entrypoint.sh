#!/bin/bash
set -e

# allow arguments
if [ "${1:0:1}" = '-' ]; then
  echo "Arg:""$@"
  set -- ./iroffer "$@"
fi

init_config() {
# Config
  mkdir -p ${IROFFER_CONFIG_DIR}
  chmod -R 0755 ${IROFFER_CONFIG_DIR}
  chown -R ${IROFFER_USER}: ${IROFFER_CONFIG_DIR}

# Data
  mkdir -p ${IROFFER_DATA_DIR}
  touch ${IROFFER_DATA_DIR}/packlist.txt
  chmod -R 0750 ${IROFFER_DATA_DIR}
  chown -R ${IROFFER_USER}: ${IROFFER_DATA_DIR}

# Logs
  mkdir -p ${IROFFER_LOG_DIR}
  touch ${IROFFER_LOG_DIR}/mybot.log
  chmod -R 0755 ${IROFFER_LOG_DIR}
  chown -R ${IROFFER_USER}: ${IROFFER_LOG_DIR}
}

# Startup
if [[ -z ${1} ]]; then
# default
# prep
  init_config
  exec ./iroffer -kns -u ${IROFFER_USER} -w $USER/ ${IROFFER_CONFIG_DIR}/mybot.config
else
# -?|-h|-v|-c
  exec "$@"
fi