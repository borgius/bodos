FROM php:5.6.12-fpm
MAINTAINER borgius <e3w2q1@gmail.com>

WORKDIR /root


RUN apt-get update && apt-get install -y php5-dev unzip wget git re2c \
  libssl-dev libbz2-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
  libmcrypt-dev libpq-dev libsqlite3-dev libuv-dev libxml2-dev \
  libmemcached-dev zlib1g-dev libncurses5-dev \
  postgresql-client-common postgresql-client-9.4 \
  --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install memcached
COPY build/memcached-2.2.0.tgz /tmp/memcached-2.2.0.tgz
RUN tar -xf /tmp/memcached-2.2.0.tgz -C /usr/src/php/ext/ && rm /tmp/memcached-2.2.0.tgz

RUN cd /tmp/ && \
    curl -O http://pecl.php.net/get/memcache-2.2.7.tgz && \
    tar zxvf memcache-2.2.7.tgz && \
    mv memcache-2.2.7 /usr/src/php/ext/memcache

RUN cd /tmp/ && \
    curl -O http://pecl.php.net/get/xdebug-2.3.2.tgz && \
    tar zxvf xdebug-2.3.2.tgz && \
    mv xdebug-2.3.2 /usr/src/php/ext/xdebug

RUN cd /tmp/ && \
    curl -O https://pecl.php.net/get/xhprof-0.9.4.tgz && \
    tar zxvf xhprof-0.9.4.tgz && \
    mv xhprof-0.9.4/extension /usr/src/php/ext/xhprof

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/ --with-png-dir=/usr/include/

# Install ext
RUN docker-php-ext-install ftp bcmath bz2 dba gd mbstring mcrypt pgsql mysql mysqli pdo_mysql pdo_pgsql \
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

ADD build/etc /usr/local/etc
COPY build/start.sh /usr/local/bin/start.sh

RUN adduser --quiet --disabled-password --gecos "" --home /data/www --uid 1000 www && usermod -g www-data www
#CMD ["start.sh"]