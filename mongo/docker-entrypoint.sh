#!/bin/bash
path=$(cd `dirname $0`;pwd)
pfile=custom_params.conf
if [ -f "$pfile" ];then
 rsname=`cat $pfile|grep rsname=*`
 rsname=${rsname#*=}
 echo -e "\033[33myour rsname is :$rsname\033[0m"
 host=`cat $pfile|grep host=*`
 host=${host#*=}
 echo -e "\033[33myour host is :$host\033[0m"
 pass=`cat $pfile|grep password=*`
 pass=${pass#*=}
 echo -e "\033[33myour pass word is :******${pass:3}\033[0m"
 username=`cat $pfile|grep username=*`
 username=${username#*=}
 echo -e "\033[33myour db user is :$username\033[0m"
 RSNAME=$rsname HOST=$host  envsubst < $path/tmpl/create_replSet.tmpl > $path/create_replSet.data
 USER=$username PASS=$pass envsubst < $path/tmpl/pass.tmpl > $path/pass.data
 else
 echo -e "\033[31mnot found this $pfile,please build it!\033[0m"
 exit
fi

build(){
for dir in `seq 27000 27002`;do
  mkdir -p work_spac
  mkdir -p work_spac/$dir
  mkdir -p work_spac/$dir/data
  mkdir -p work_spac/$dir/conf
  mkdir -p work_spac/$dir/logs
  PORT=$dir RSNAME=$rsname DIR=${path}/work_spac ACCESS=${path}  envsubst < $path/tmpl/conf.tmpl > $path/work_spac/$dir/conf/mongodb.conf
done
start_replSet
init_replSet
}

init_replSet(){
echo -e "\033[33mcreate replSet,pleasse wait..\033[0m"

$path/bin/mongo 127.0.0.1:27000 < create_replSet.data
sleep 3s
echo -e "\033[32mcreate replSet end!\033[0m"

add_user

restart_mongodb

}

add_user(){
 echo -e "\033[33madd user:$username,pleasse wait..\033[0m"
 sleep 10s
 $path/bin/mongo 127.0.0.1:27000 < pass.data
 echo -e "\033[33madd user end \033[0m"
}


init_access(){
echo -e "\033[32minit access.key\033[0m"
openssl rand -base64 756 > access.key
chmod 400 access.key

for dir in `seq 27000 27002`;do
 sed -i "s/\#    keyFile/     keyFile/g" $dir/work_spac/conf/mongodb.conf
 sed -i "s/\#security/security/g" $dir/work_spac/conf/mongodb.conf
 sed -i "s/\#    authorization/     authorization/g" $dir/work_spac/conf/mongodb.conf
done
sleep 500
echo -e "\033[32minit access.key done\033[0m"
}




restart_mongodb(){
# stop
shutdown_replSet
# start
start_replSet

echo -e "\033[32mrestart mongodb end\033[0m"

echo -e "\033[32mnow you can connect your mongodb replSet ,over!\033[0m"

echo inited=true > work_spac/inited
}

shutdown_replSet(){
echo -e "\033[33mshutdown mongodb,please wait..\033[0m"
# stop
for dir in `seq 27000 27002`;do
  kill -2 `cat $path/work_spac/$dir/mongod.pid`
  echo -e "\033[32mstop successed mongodb port $dir\033[0m"
  sleep 1s
done

echo -e "\033[33mshutdown mongodb end!\033[0m"

}


start_replSet(){
echo -e "\033[33mstartup mongodb replset plesase wait\033[0m"
for dir in `seq 27000 27002`;do 
 $path/bin/mongod -f $path/work_spac/$dir/conf/mongodb.conf
 sleep 1s
done
}

if [ -f "work_spac/inited" ];then
 start_replSet
 else
 build
fi

exec "$@"
#tail -f /dev/null
#exec "$@"
