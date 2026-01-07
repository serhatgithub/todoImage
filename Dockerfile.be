FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Temel paketlerin kurulumu
RUN apt-get update && apt-get install -y \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    apache2 \
    php \
    libapache2-mod-php \
    php-bcmath \
    php-gd \
    php-sqlite3 \
    php-mysql \
    php-curl \
    php-xml \
    php-mbstring \
    php-zip \
    nano \
    locales \
    && apt-get clean all

# Dil ayarları
RUN locale-gen fr_FR.UTF-8 en_US.UTF-8 de_DE.UTF-8

# PHP Konfigürasyonu (Klasör yolu php/8.0 yerine php/7.4 oldu)
RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.4/apache2/php.ini \
    && sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /etc/php/7.4/apache2/php.ini \
    && sed -i -e 's/^zlib.output_compression\s*=.*/zlib.output_compression = Off/' /etc/php/7.4/apache2/php.ini

ENV TERM xterm

# Apache Konfigürasyonu
RUN a2enmod rewrite \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# İzinlerin düzenlenmesi
RUN chgrp -R www-data /var/www \
    && find /var/www -type d -exec chmod 775 {} + \
    && find /var/www -type f -exec chmod 664 {} +

EXPOSE 80

# Dosyaların kopyalanması
COPY ./api/ /var/www/html/
RUN rm -f /var/www/html/index.html 

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]