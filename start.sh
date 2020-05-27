#!/bin/bash

source /etc/bashrc

set -e

container_role=${CONTAINER_ROLE:-app}

ip -4 route list match 0/0 | awk '{print $$3" host.docker.internal"}' >> /etc/hosts

if [ ! -z "$ENABLE_XDEBUG" ]; then
  echo "*** Enabling xdebug"
  docker-php-ext-enable xdebug
fi

if [ "$container_role" = "web" ]; then

    echo "Running as web server"

    rm -rf /run/httpd/* /tmp/httpd*

    cd /var/www && /usr/local/bin/composer install --no-interaction

    cd /var/www && sleep 3 && php artisan migrate --force

    exec /usr/local/bin/apache2-foreground

elif [ "$container_role" = "web_no_database" ]; then

    echo "Running as web server with no database"

    rm -rf /run/httpd/* /tmp/httpd*

    cd /var/www && /usr/local/bin/composer install --no-interaction

    exec /usr/local/bin/apache2-foreground
	
elif [ "$container_role" = "cli" ]; then

    echo "Running as CLI"

else

    echo "Invalid value for container role \"$container_role\""
    exit 1 
fi
