#!/usr/bin/env bash

service php${PHP_VERSION}-fpm start
nginx -g 'daemon off;'
