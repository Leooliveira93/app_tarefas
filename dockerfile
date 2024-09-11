# Usando a imagem base do PHP com Apache
FROM php:7.4-apache

# Atualiza os pacotes e instala as dependências necessárias
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    curl \
    zip \
    libicu-dev \
    g++ \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl

# Habilita o mod_rewrite do Apache
RUN a2enmod rewrite

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia o código-fonte da aplicação para o container
COPY . /var/www/html

# Define permissões apropriadas para os arquivos
RUN chown -R www-data:www-data /var/www/html

# Exponha a porta 80
EXPOSE 80

# Substitui o arquivo de configuração do Apache para definir o DocumentRoot
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Reinicia o Apache
CMD ["apache2-foreground"]
