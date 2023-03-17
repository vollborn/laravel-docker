# install composer packages
FROM composer:2 AS composer

COPY ./app /app

WORKDIR /app

RUN composer install --no-interaction --ignore-platform-reqs

# end build, final container
FROM ubuntu:22.04 AS laravel

ARG TZ="Europe/Berlin"
ARG PHP_VERSION="8.2"
ENV PHP_VERSION=${PHP_VERSION}

WORKDIR /app

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y  \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-ctype \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-dom \
        php${PHP_VERSION}-fileinfo \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-tokenizer \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-pdo \
        php${PHP_VERSION}-redis

RUN apt-get install -y nginx

COPY ./src/nginx.conf /etc/nginx/sites-available/default
RUN sed -i "s/{{PHP_VERSION}}/${PHP_VERSION}/" /etc/nginx/sites-available/default

COPY ./src/entrypoint.sh /opt/entrypoint.sh

COPY --from=composer /app .
RUN chown -R www-data /app

ENTRYPOINT ["bash"]
CMD ["/opt/entrypoint.sh", "${PHP_VERSION}"]
