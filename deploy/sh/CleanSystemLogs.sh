#!/bin/bash

for i in `find /var/log/*`
do
  result=$(echo $i | grep "mysql")
  if [[ "$result" == "" ]]; then
    if [ ! -d $i ]; then
      cat /dev/null > $i
    fi
  fi
done