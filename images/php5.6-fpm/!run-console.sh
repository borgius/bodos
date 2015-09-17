#!/bin/sh
docker run --name php_test --rm -ti --volumes-from bodos_data_1 borgius/php-phalcon bash -l