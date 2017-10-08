# start off with a small linux distro
FROM alpine:3.6
# update and upgrade our package manager
RUN apk upgrade
# install webserver
RUN apk add --update nginx
# install PHP and the CGI server that’ll communicate between the web server and PHP
RUN apk add --update php7 php7-fpm
# clean up
RUN rm -rf /var/cache/apk/*

# necessary directories when nginx and php servers are ran they create files here
RUN mkdir /run/nginx
RUN mkdir /run/php

# copy over our updated configurations
ADD ./config/nginx.conf /etc/nginx/conf.d/default.conf
ADD ./config/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
ADD ./config/www.conf /etc/php7/php-fpm.d/www.conf

# copy our code
ADD ./src/* /var/lib/nginx/html/

# and our long running process to keep our docker container running
CMD php-fpm7 && nginx -g 'daemon off;'
