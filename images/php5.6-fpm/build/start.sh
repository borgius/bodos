#!/bin/bash

# Create /ram directory if the enrivonment variable RAM_SIZE is set
if [ ! -z "$RAM_SIZE" ]
then
    RAM_SIZE=${RAM_SIZE:-"256"}

    if [ ! -d "/ram" ]; then
        mkdir /ram
    fi
    mount -t tmpfs -o size="${RAM_SIZE}m" tmpfs /ram
fi

# Create /ram directory if the enrivonment variable RAM_SIZE is set
if [ ! -z "$PHP_ENV" ]
then
    PHP_ENV=${PHP_ENV:-""}
    if [ -f "/usr/local/etc/php/$PHP_ENV.ini" ]
    then
      cat /usr/local/etc/php/$PHP_ENV.ini >> /usr/local/etc/php/php.ini
    fi
fi

# Start php-fpm
php-fpm --allow-to-run-as-root
