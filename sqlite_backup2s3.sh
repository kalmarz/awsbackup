#!/usr/bin/env bash

DB=$1
DATE=`date -u '+%d%m%Y-%H%M'`
DUMP_FILE=/tmp/${DB}-backup-${DATE}.sqlite3

echo "creating database dump for ${DB}..."
sqlite3 /data/db.sqlite3 ".backup '${DUMP_FILE}'"
gzip $DUMP_FILE

echo "uploading ${DUMP_FILE}.gz to S3..."
if [ -s ${DUMP_FILE}.gz ]; then
  aws s3 cp --no-progress ${DUMP_FILE}.gz ${BACKUP_BUCKET}/${DB}/
else
  echo "couldn't find ${DUMP_FILE}.gz to copy... exiting"
  exit 1
fi

echo "cleaning up..."
rm ${DUMP_FILE}.gz

echo "completed"