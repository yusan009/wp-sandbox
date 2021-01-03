FROM wordpress:latest

ENV APACHE_SERVER_NAME="localhost" \
    APACHE_RUN_USER="wp-sandbox" \
    APACHE_RUN_GROUP="wp-sandbox"

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --info

RUN apt update && apt install -y default-mysql-client 

COPY docker-entrypoint.sh /tmp/
COPY setup_wordpress.sh /tmp/

ENTRYPOINT ["/tmp/docker-entrypoint.sh"]