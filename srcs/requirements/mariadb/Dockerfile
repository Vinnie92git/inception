#image OS
FROM debian:buster

#install mariadb
RUN apt update -y && apt install -y mariadb-server

#change the default database configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#create the directories for the sockets
RUN mkdir -p /var/run/mysqld \
		&& chown -R mysql:mysql /var/run/mysqld \
		&& chmod 777 /var/run/mysqld

#copy and run the script for database initialization
COPY ./tools/init.sh /

RUN chmod +x /init.sh

EXPOSE 3306

CMD ["/init.sh"]

# CMD ["mysqld"]