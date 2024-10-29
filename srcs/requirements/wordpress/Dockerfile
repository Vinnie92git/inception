#image OS
FROM debian:buster

#install wordpress dependencies
RUN apt update -y && apt install -y php-fpm php-mysql curl
RUN mkdir -p /var/www/html

#download wp-cli and give permissions
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp

#copy and execute script to auto-configure wp installation
COPY ./tools/auto-config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto-config.sh
ENTRYPOINT ["/usr/local/bin/auto-config.sh"]

RUN mkdir /run/php

EXPOSE 9000

# WORKDIR /var/www/html/

CMD ["/usr/sbin/php-fpm7.3", "-F"]