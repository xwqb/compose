#!/bin/bash
path=$(cd `dirname $0`;pwd)
pfile=custom_params.conf

if [ ! -f $pfile ];then
 echo "not found custom_params.conf!"
 exit
fi

for line in `cat $pfile|grep "password"`;do
 PASS="requirepass "${line#*=}
done

if [ ! "$PASS" ];then
 PASS="#requirepass foorbar" 
fi


for dir in `seq 7000 7005`;do
 mkdir -p work_spac/$dir
 echo "mkdir -p dir -> $dir"
 PORT=$dir PASS=$PASS envsubst < $path/redis-cluster.tmpl > work_spac/$dir/redis-cluster_$dir.conf
done

# start redis-cluster
startRedisCluster(){
 for dir in `seq 7000 7005`;do
  echo "$path/work_spac/$dir"
  cd $path/work_spac/$dir
  redis-server redis-cluster_$dir.conf
 done
}

pfile=$path/custom_params.conf
# trib-redis
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
 
  if [ ! -f "$path/work_spac/clusterd.conf" ];then
   startRedisCluster
   sleep 2s
   echo "redis-cli  --cluster create --cluster-replicas 1 $cluster $password"
   echo "first build cluster"
   echo "yes" | redis-cli  --cluster create --cluster-replicas 1 $cluster $password
   echo "clustered=true" > $path/work_spac/clusterd.conf
  else
   echo "found $path/work_spac/cluster.conf start-redis-cluster"
   startRedisCluster
  fi
 else
  echo "not found file $pfile"
 fi
}
readParam

tail -f /dev/null
