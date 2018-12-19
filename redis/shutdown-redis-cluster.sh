#!/bin/bash

pfile=custom_params.conf
for line in `cat $pfile|grep "port"`;do
 PORT=" "${line#*=}
done

if [ ! "$PORT" ];then
 PORT="7000 7005 "
else
 PORT=${PORT/\-/" "}
fi

for dir in `seq $PORT`;do
  kill -9 `cat /var/run/redis_$dir.pid`
done
