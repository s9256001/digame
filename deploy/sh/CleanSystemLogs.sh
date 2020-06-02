#!/bin/bash

for i in `find /var/log/*`
do
  mysql=$(echo $i | grep "mysql")
  gz=$(echo $i | grep "gz")
  if [[ "$mysql" == "" ]]; then
    if [ ! -d $i ]; then
      if [[ "$gz" != "" ]]; then
        rm -r $i
      else 
        cat /dev/null > $i
      fi
    fi
  fi
done
