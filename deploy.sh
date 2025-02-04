#!/bin/bash

if (( $EUID != 0 )); then
	echo "Please run as root"
	exit
fi

SRV_NAME=ethstats
APP_NAME=ethstats-server
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DST_DIR=/var/spool/geth/

echo "RUNNING systemctl stop ${SRV_NAME}" && \
systemctl stop ${SRV_NAME} && \
echo "RUNNING rm -rf ${DST_DIR}${APP_NAME}" && \
rm -rf ${DST_DIR}${APP_NAME} && \
echo "RUNNING cp -r ${SRC_DIR} ${DST_DIR}" && \
cp -r ${SRC_DIR} ${DST_DIR} && \
echo "RUNNING chown -R geth:geth ${DST_DIR}${APP_NAME}" && \
chown -R geth:geth ${DST_DIR}${APP_NAME} && \
echo "RUNNING systemctl start ${SRV_NAME}" && \
systemctl start ${SRV_NAME} && \
echo "RUNNING journalctl -u ${SRV_NAME} -f" && \
journalctl -u ${SRV_NAME} -f
