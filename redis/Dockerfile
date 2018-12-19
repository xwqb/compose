FROM centos:7.5.1804

MAINTAINER Redis docker image  'xiaoweiqb@126.com'

RUN yum -y install  wget gettext autoconf automake  make gcc-c++

ENV redis-version 5.0.2



WORKDIR ./

RUN mkdir /redis \
	&& cd /redis && mkdir cluster  \
 	&& wget http://download.redis.io/releases/redis-5.0.2.tar.gz \
	&& tar -xzf redis-5.0.2.tar.gz \
	&& cd redis-5.0.2 \
	&& make && make install

WORKDIR /redis/cluster

COPY build.sh /redis/cluster
COPY custom_params.conf /redis/cluster
COPY redis-cluster.tmpl /redis/cluster
COPY start-redis-cluster.sh /redis/cluster
COPY shutdown-redis-cluster.sh /redis/cluster


EXPOSE 7000 7001 7002 7003 7004 7005

#CMD /redis/cluster/build.sh && /redis/cluster/start-redis-cluster.sh && tail -f /dev/null
CMD echo "this is Docker file echo"

	 
