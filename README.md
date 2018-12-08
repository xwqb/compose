# docker-compose
 help you build services quickly
## The `docker-compose.yml` include elasticsearch mysql redis-cluster's build in compose plugin action,you can set your volumes path for your system and uptate your some service's password in this!
### first
 you will run this `/bin/bash init-compose.sh` set your system,if so ,skip it!
for example:
#### nginx
 build your host file in `conf/conf.d` path,of course it include ssl certificate support
#### redis
 you want to set your external ip in this redis cluster,you can update `custom_paramas.conf` set `redis-password=yourpassword` 
if you want to the redis-cluster provide access to external network you can  set `redis-host=yourexternalipaddress` 
#### elasticsearch
 This elasticsearch service only a stand-alone instance,but it will help you build a demo service in your dev environment
#### mysql
 You can set your password in this `docker-compose.yml`, but it not security,you should optimize this way!
#### mogodb
 This docker image only support three nodes that 27000-27002,if you can build more nodes,you should update some file,this is standonle replSet in one machine,if there are many other machines,you need to modify some files to achieve the purpose, edit `mongo/custom_params.conf` set your host and password

## Summary
 I'll keep updating more services,such as fastDFS,mongoDB,zookeeper,kafka,jenkins and gogs so on
