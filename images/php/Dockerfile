FROM phusion/baseimage:0.9.16

# Prepare basic deps
RUN locale-gen en_US.UTF-8 \
 && /etc/my_init.d/00_regen_ssh_host_keys.sh \
 && apt-get update && apt-get install -y wget  \
 && echo "deb http://packages.dotdeb.org wheezy-php56 all" | tee -a /etc/apt/sources.list \
 && echo "deb-src http://packages.dotdeb.org wheezy-php56 all" | tee -a /etc/apt/sources.list \
 && wget http://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg \
 && apt-get update \
 && apt-get install -y curl build-essential git gcc make \
            php5-cli php5-fpm php5-dev php5-curl php5-pgsql php5-redis \
            openssl libuv-dev libxml2-dev libcurl4-openssl-dev pkg-config libpcre3-dev  \
 ###### allow manipulation with ENV variables \
 && sed -i 's/variables_order = .*/variables_order = "EGPCS"/' /etc/php5/cli/php.ini \
 && sed -i 's/safe_mode_allowed_env_vars = .*/safe_mode_allowed_env_vars = ""/' /etc/php5/cli/php.ini  \
 && sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf \
 && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini \
 ###### install php-uv \
 && git clone https://github.com/chobie/php-uv.git --recursive /tmp/php-uv \
 && cd /tmp/php-uv && phpize && ./configure && make && make install \
 && echo "extension=uv.so" > /etc/php5/mods-available/uv.ini \
 && php5enmod uv \
 ###### Install Phalcon \
 && git clone --depth=1 git://github.com/phalcon/cphalcon.git /tmp/cphalcon \
 && cd /tmp/cphalcon/build \
 && ./install \
 && echo "extension=phalcon.so" > /etc/php5/mods-available/phalcon.ini \
 && php5enmod phalcon \
 ###### Install MsgPack \
 && git clone --depth=1 git://github.com/msgpack/msgpack-php.git /tmp/msgpack \
 && cd /tmp/msgpack \
 && phpize && ./configure \
 && make && make install \
 && echo "extension=msgpack.so" > /etc/php5/mods-available/msgpack.ini \
 && php5enmod msgpack \
 ###### Install Yaml \
 && cd /tmp && wget http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz && tar zxvf yaml-0.1.5.tar.gz && cd yaml-0.1.5 \
 && ./configure && make install && pecl install yaml \
 && echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini \
 && php5enmod yaml \
 ###### Install Composer \
 && curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer \
 && mkdir /etc/service/phpfpm && echo "#!/usr/bin/env bash\n\nphp5-fpm -c /etc/php5/fpm" >/etc/service/phpfpm/run \
 && chmod +x /etc/service/phpfpm/run \
 && rm -rf /etc/php5/fpm/pool.d  \
 && mkdir -p /etc/php5/fpm/pool.d /data/run


ADD ./build/etc /etc

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
