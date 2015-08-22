#!/bin/bash

case "$1" in
        step1)
	    apt-get update && apt-get install -y --no-install-recommends build-essential curl nano wget git-core ca-certificates
            ;;
            
        step2)
	    cd /usr/local/src
	    wget http://uk1.php.net/get/php-5.6.12.tar.gz/from/this/mirror -O php.tar.gz
	    tar xzvf php.tar.gz
	    cd php-5.6.12/ext
	    git clone https://github.com/krakjoe/pthreads.git
	    wget http://pecl.php.net/get/mongo-1.6.10.tgz
	    tar xzvf mongo-1.6.10.tgz
	    cd ..
            ;;
         
         
        *)
            echo $"Usage: $0 {step1|step2|step3|step4|step5}"
            exit 1
 
esac