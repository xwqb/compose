#!/bin/bash
set -e
pfile=custom_params.conf
readParam(){
 if [ -f "$pfile" ];then
  for line in `cat $pfile|grep -v "#"`;do
    if [[ $line =~ host.* ]];then
     host=${line#*=}
     if [[ $host ]];then
      for port in `seq 7000 7005`;do
       cluster=$cluster" "$host:$port
      done
     fi
    fi
 
   if [[ $line =~ password.* ]];then
    password=${line#*=} 
   fi
  done
 if [[ $password ]];then
  password="-a $password"
 else
  echo "not found password"
 fi
  if [ ! -f "clusterd.conf" ];then
   echo "redis-cli  --cluster create --cluster-replicas 1 $cluster $password"
   echo "yes" | redis-cli  --cluster create --cluster-replicas 1 $cluster $password
   echo "firt build cluster"
   echo "clustered=true" > clusterd.conf
  else
   echo "found cluster.conf exec /redis/cluster/start-redis-cluster.sh"
   exec /redis/cluster/start-redis-cluster.sh
  fi
 else
  echo "not found file"
 fi
}
readParam

