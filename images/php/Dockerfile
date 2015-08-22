FROM ubuntu:14.04

ENV PHP_VER=5.6.12

COPY build /

RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main' | tee /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty main' | tee -a /etc/apt/sources.list \
 && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates main' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main' | tee -a /etc/apt/sources.list \
 && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty universe' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty universe' | tee -a /etc/apt/sources.list \
 && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe' | tee -a /etc/apt/sources.list \
 && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb http://security.ubuntu.com/ubuntu trusty-security main' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://security.ubuntu.com/ubuntu trusty-security main' | tee -a /etc/apt/sources.list \
 && echo 'deb http://security.ubuntu.com/ubuntu trusty-security universe' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://security.ubuntu.com/ubuntu trusty-security universe' | tee -a /etc/apt/sources.list \
 && echo 'deb http://security.ubuntu.com/ubuntu trusty-security multiverse' | tee -a /etc/apt/sources.list \
 && echo 'deb-src http://security.ubuntu.com/ubuntu trusty-security multiverse' | tee -a /etc/apt/sources.list

RUN apt-get update && \
    apt-get upgrade -y -q && \
    apt-get dist-upgrade -y -q && \
    apt-get -y -q autoclean && \
    apt-get -y -q autoremove

RUN apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    nano \
    wget \
    git \
    ca-certificates \
    libmemcached-dev \
    libmcrypt-dev \
    libcurl4-openssl-dev \
    libgd2-xpm-dev \
    libmysqlclient-dev \
    zlib1g-dev \
    libmongo-client-dev \
    libssl1.0.0-dbg \
    libssl-dev \
    libsslcommon2-dev \
    libgd2-xpm-dev \
    libbz2-dev \
    libfreetype6-dev \
    libpng12-dev \
    libpq-dev \
    libsqlite3-dev \
    libuv-dev \
    libxml2-dev \
    libmemcached-dev \
    zlib1g-dev \
    libncurses5-dev
    
# e2c  libjpeg62-turbo-dev

ENV PHP_PATH=/usr/src/php

RUN wget http://uk1.php.net/get/php-$PHP_VER.tar.gz/from/this/mirror -O /tmp/php.tar.gz 
RUN mkdir -p $PHP_PATH && tar xzvf /tmp/php.tar.gz -C $PHP_PATH --strip-components=1 
RUN cd $PHP_PATH/ext \
  && git clone https://github.com/krakjoe/pthreads.git \
  && wget http://pecl.php.net/get/mongo-1.6.10.tgz \
  && tar xzvf mongo-1.6.10.tgz

RUN apt-get install -y autoconf

RUN cd $PHP_PATH \
  && ./buildconf --force \
  && ./configure \
--disable-cgi \
--enable-bcmath \
--enable-dba \
--enable-debug \
--enable-exif \
--enable-ftp \
--enable-gd-native-ttf \
--enable-maintainer-zts \
--enable-mbstring \
--enable-mysqlnd \
--enable-opcache \
--enable-pcntl \
--enable-pthreads \
--enable-shmop \
--enable-soap \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-wddx \
--enable-zip \
--prefix=/usr/local/src/php-$PHP_VER \
--with-config-file-path=:$PHP_PATH/etc \
--with-curl \
--with-gd \
--with-gettext \
--with-jpeg-dir=/usr/lib/x86_64-linux-gnu \
--with-libdir=/usr/lib/x86_64-linux-gnu \
--with-mysql \
--with-mysql-sock=/var/run/mysqld/mysqld.sock \
--with-mysqli \
--with-openssl \
--with-openssl-dir=/usr/bin \
--with-pdo-mysql \
--with-pdo-pgsql \
--with-zlib 

RUN cd $PHP_PATH && make && make install \
  && chmod o+x $PHP_PATH/scripts/phpize && chmod o+x $PHP_PATH/scripts/php-config

RUN cd $PHP_PATH/ext/mongo* \
 && $PHP_PATH/scripts/phpize \
 && ./configure --prefix $PHP_PATH \
 --with-libdir=/lib/x86_64-linux-gnu \
 --enable-mongo --with-php-config=$PHP_PATH/scripts/php-config \
 && make && make install
 
RUN cd /tmp/ && \
    curl -O http://pecl.php.net/get/memcache-2.2.7.tgz && \
    tar zxvf memcache-2.2.7.tgz && \
    mv memcache-2.2.7 $PHP_PATH/ext/memcache

RUN cd /tmp/ && \
    curl -O http://pecl.php.net/get/xdebug-2.3.2.tgz && \
    tar zxvf xdebug-2.3.2.tgz && \
    mv xdebug-2.3.2 $PHP_PATH/ext/xdebug

RUN cd /tmp/ && \
    curl -O https://pecl.php.net/get/xhprof-0.9.4.tgz && \
    tar zxvf xhprof-0.9.4.tgz && \
    mv xhprof-0.9.4/extension $PHP_PATH/ext/xhprof

#RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/ --with-png-dir=/usr/include/

# Install ext
RUN docker-php-ext-install ftp bcmath bz2 dba gd mbstring mcrypt  \
    xdebug xhprof memcached-2.2.0 memcache

COPY build/zzz_xdebug.ini /usr/local/etc/php/conf.d/zzz_xdebug.ini
RUN mkdir /usr/local/lib/php/session && chown www-data.www-data /usr/local/lib/php/session

# Install phpredis 2.2.7
COPY build/phpredis-2.2.7.zip /tmp/phpredis-2.2.7.zip
RUN cd /tmp && unzip phpredis-2.2.7.zip && cd phpredis-2.2.7 && \
    phpize && ./configure && make && make install && \
    cp modules/redis.so /usr/lib/php5/20131226/ && \
   echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini


#RUN git clone https://github.com/chobie/php-uv.git --recursive /tmp/php-uv \
# && cd /tmp/php-uv && phpize && ./configure && make && make install \
# && echo "extension=uv.so" > /usr/local/etc/php/conf.d/uv.ini

RUN git clone --depth=1 git://github.com/phalcon/cphalcon.git /tmp/cphalcon \
 && cd /tmp/cphalcon/build \
 && ./install \
 && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon2.ini

RUN git clone --depth=1 git://github.com/msgpack/msgpack-php.git /tmp/msgpack \
 && cd /tmp/msgpack \
 && phpize && ./configure \
 && make && make install \
 && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini

RUN cd /tmp && wget http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz && tar zxvf yaml-0.1.5.tar.gz && cd yaml-0.1.5 \
 && ./configure && make install && pecl install yaml \
 && echo "extension=yaml.so" > /usr/local/etc/php/conf.d/yaml.ini

RUN cd /tmp && wget https://github.com/alexeyrybak/blitz/archive/0.9.1.tar.gz && tar zxvf 0.9.1.tar.gz && cd blitz-0.9.1 \
 && phpize && ./configure && make install \
 && echo "extension=blitz.so" > /usr/local/etc/php/conf.d/blitz.ini

ENV COMPOSER_HOME /root/composer
ENV COMPOSER_VERSION master
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Display version information
RUN composer --version
 
 