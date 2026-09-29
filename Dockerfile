FROM php:8.3-apache

ENV APP_ENV=production \
    SESSION_COOKIE_SECURE=1

RUN docker-php-ext-install opcache \
    && a2enmod headers rewrite expires \
    && sed -i 's/^ServerTokens .*/ServerTokens Prod/; s/^ServerSignature .*/ServerSignature Off/' /etc/apache2/conf-available/security.conf \
    && sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
    && a2dissite 000-default \
    && mkdir -p /var/run/apache2 /var/lock/apache2 \
    && chown -R www-data:www-data /var/run/apache2 /var/lock/apache2

WORKDIR /var/www/x-security

COPY --chown=www-data:www-data index.php ./
COPY --chown=www-data:www-data assets/ ./assets/
COPY docker/000-default.conf /etc/apache2/sites-available/x-security.conf
COPY docker/php.ini /usr/local/etc/php/conf.d/zz-production.ini

RUN a2ensite x-security

USER www-data

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD php -r '$h=@file_get_contents("http://127.0.0.1:8080/healthz"); exit($h === "ok" ? 0 : 1);'

CMD ["apache2-foreground"]
