path=$(cd `dirname $0`;pwd)
docker run --name redis -v $path/work_spac:/redis/cluster/work_spac --privileged=true --net=host -d redis:5.0.2
docker exec redis /bin/bash /redis/cluster/trib-cluster.sh
