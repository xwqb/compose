#!/bin/bash
for dir in `seq 7000 7005`;do
  kill -9 `cat /var/run/redis_$dir.pid`
done
