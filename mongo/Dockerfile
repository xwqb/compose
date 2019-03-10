FROM centos:7.5.1804

MAINTAINER Mongodb-replSet docker image  'xiaoweiqb@126.com'

RUN yum -y install wget gettext openssl

ENV mongodb-version 4.0.4

WORKDIR /home

COPY mongodb-linux-x86_64-4.0.6.tgz /home/

RUN     tar -xzf mongodb-linux-x86_64-4.0.6.tgz \
	&& mv mongodb-linux-x86_64-4.0.6 mongodb \
	&& cd mongodb \
	&& mkdir tmpl 

WORKDIR /home/mongodb

COPY tmpl/* tmpl/
COPY custom_params.conf custom_params.conf
COPY docker-entrypoint.sh docker-entrypoint.sh
COPY shutdown.sh shutdown.sh

EXPOSE 27000 27001 27002

ENTRYPOINT ["/home/mongodb/docker-entrypoint.sh"]
#CMD ["docker-entrypoint.sh"]

#CMD /home/mongodb/startup.sh && tail -f /dev/null
#CMD tail -f /dev/null




