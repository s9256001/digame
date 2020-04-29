#!/bin/bash

if [ ! -d "backups" ]; then
  mkdir backups
fi

filename=backups/$(date +%Y-%m-%d).sql
if [ -f $filename ]; then
  rm -r $filename
fi

mysqldump -uroot -pwoer.net --databases digame diwallet > $filename
find backups/*.sql -mtime +6 -type f -delete