# docker-compose
docker-compose
## the docker-compose.yml include elasticsearch mysql redis-cluster's build in compose plugin action,you can set your volumes path for your system and uptate your some service's password in this!
### for example:
#### redis
  you want's set your external ip in this redis cluster,you can update `custom_paramas.conf` and set `redis-password=yourpassword`,if you wan't the redis-cluster provide access to external network you can update `redis-ip` and set `redis-ip=yourexternalipaddress`
