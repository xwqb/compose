#!/bin/bash
path=$(cd `dirname $0`;pwd)

for dir in `seq 27000 27002`;do
  kill -2 `cat $path/work_spac/$dir/mongod.pid`
  echo -e "\033[32mstop successed mongodb port $dir\033[0m"
done
