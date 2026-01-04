# 1. PHP 8.0 ve Apache
FROM php:8.0-apache

# 2. Gerekli sistem kütüphanelerini kur
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libsqlite3-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. PHP Eklentilerini kur
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    gd \
    mysqli \
    pdo_mysql \
    pdo_sqlite \
    zip \
    xml \
    mbstring \
    curl

# 4. Apache Rewrite Modülünü aktif et
RUN a2enmod rewrite

# 5. Çalışma dizini
WORKDIR /var/www/html

# 6. Kodları bilgisayarından konteynerın içine kopyala (KRİTİK EKSİK BUYDU)
COPY . /var/www/html

# 7. Portu aç
EXPOSE 80