FROM ubuntu:14.04

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -q -y python python-dev python-pip build-essential postgresql postgresql-server-dev-all postgresql-client

RUN pip install psycopg2
RUN pip install Django==1.5

ADD ./askbot-0.7.49.tar.gz /tmp/dist
RUN pip install /tmp/dist/askbot-0.7.49

ADD ./askbot-home /var/lib/askbot-home

RUN apt-get install -q -y openssh-server supervisor

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

RUN echo 'root:root' |chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 666 /etc/postgresql/9.3/main/postgresql.conf
RUN chmod 666 /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "standard_conforming_strings = off" >> /etc/postgresql/9.3/main/postgresql.conf
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf
RUN echo "#TYPE   DATABASE  USER  CIDR-ADDRESS  METHOD" > /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "local   all       all                 trust" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "host    all       all   127.0.0.1/32  trust" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "host    all       all   ::1/128       trust" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "host    all       all   0.0.0.0/0     md5" >> /etc/postgresql/9.3/main/pg_hba.conf

USER postgres

RUN		/etc/init.d/postgresql start &&\
			psql --command "CREATE USER askbot WITH ENCRYPTED PASSWORD 'qua6shoo8shu9hohg3zohch4saekietheigie5OoMai9wungo0jae0suungoFuiy';" &&\
			psql --command "CREATE DATABASE askbot ENCODING 'UTF8' OWNER askbot TEMPLATE template0;"

USER root

CMD ["/usr/bin/supervisord"]