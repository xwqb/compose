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


#EXPOSE 7005 7006 7007 7008 7009 7010

ENTRYPOINT ["/redis/cluster/build.sh"]

	 
