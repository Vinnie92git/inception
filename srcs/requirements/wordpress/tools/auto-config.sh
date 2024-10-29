#!/bin/bash

cd var/www/html

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wp core download --allow-root

	sed -i "s/username_here/$SQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$SQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$SQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$SQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE \
			--admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD \
			--admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

	wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

	sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

	mkdir /run/php

fi

exec "$@"