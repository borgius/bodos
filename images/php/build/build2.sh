#!/bin/bash

cd /usr/local/src
wget http://uk1.php.net/get/php-5.6.12.tar.gz/from/this/mirror -O php.tar.gz
tar xzvf php.tar.gz
cd php-5.6.12/ext
git clone https://github.com/krakjoe/pthreads.git
wget http://pecl.php.net/get/mongo-1.6.10.tgz
tar xzvf mongo-1.6.10.tgz

cd /usr/local/src/php-5.6.12
./buildconf --force && make clean

./configure
--prefix=/usr/local/src/php-5.6.12 \
--with-libdir=/lib/x86_64-linux-gnu/ \
--with-openssl=/usr --with-curl=/usr \
--disable-cgi \
--with-config-file-path=:/usr/local/src/php-5.6.12/etc \
--enable-gd-native-ttf \
--enable-mysqlnd \
--enable-opcache \
--enable-pcntl \
--enable-debug \
--enable-maintainer-zts \
--enable-pthreads \
--enable-mbstring \
--enable-bcmath \
--enable-exif \
--enable-ftp \
--enable-shmop \
--enable-soap \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-wddx \
--enable-opcache \
--enable-zip \
--enable-dba

make
make install