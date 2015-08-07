FROM debian:wheezy

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get update && apt-get install -q -y python python-dev python-pip build-essential postgresql postgresql-server-dev-all postgresql-client nginx openssh-server supervisor

RUN pip install psycopg2
RUN pip install uwsgi
RUN pip install Django==1.5

RUN apt-get update && apt-get install -q -y git
RUN pip install git+https://github.com/alexproca/askbot-devel.git#egg=askbot

ADD ./askbot-home /var/lib/askbot-home

RUN mkdir -p /var/run/sshd && mkdir -p /var/log/supervisor

# Enable ssh root access
RUN echo 'root:password' |chpasswd && sed -i s/PermitRootLogin\ without-password/PermitRootLogin\ yes/g /etc/ssh/sshd_config && sed -i s/StrictModes\ yes/StrictModes\ no/g /etc/ssh/sshd_config


ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 666 /etc/postgresql/9.1/main/postgresql.conf
RUN chmod 666 /etc/postgresql/9.1/main/pg_hba.conf
RUN echo "standard_conforming_strings = off" >> /etc/postgresql/9.1/main/postgresql.conf
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.1/main/postgresql.conf
RUN echo "#TYPE   DATABASE  USER  CIDR-ADDRESS  METHOD" > /etc/postgresql/9.1/main/pg_hba.conf
RUN echo "local   all       all                 trust" >> /etc/postgresql/9.1/main/pg_hba.conf
RUN echo "host    all       all   127.0.0.1/32  trust" >> /etc/postgresql/9.1/main/pg_hba.conf
RUN echo "host    all       all   ::1/128       trust" >> /etc/postgresql/9.1/main/pg_hba.conf
RUN echo "host    all       all   0.0.0.0/0     md5" >> /etc/postgresql/9.1/main/pg_hba.conf

USER postgres

RUN		/etc/init.d/postgresql start &&\
			psql --command "CREATE USER askbot WITH ENCRYPTED PASSWORD 'qua6shoo8shu9hohg3zohch4saekietheigie5OoMai9wungo0jae0suungoFuiy';" &&\
			psql --command "CREATE DATABASE askbot ENCODING 'UTF8' OWNER askbot TEMPLATE template0;"

USER root

CMD ["/usr/bin/supervisord"]