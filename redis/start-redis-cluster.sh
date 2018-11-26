#!/bin/bash
path=$(cd `dirname $0`;pwd)

for dir in `seq 7000 7005`;do
 echo "$path/work_spac/$dir"
 cd $path/work_spac/$dir
 redis-server redis-cluster_$dir.conf
done
