#!/bin/bash

# Update packages and install necessary packages
sudo apt update
sudo apt-get install unzip
sudo apt-get install p7zip -y

sudo apt install apache2 -y


# Add the ondrej/php repository and install PHP 8.0
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt install php8.0 -y



# to check packages installed
# sudo php -m


# Update packages and install necessary packages
sudo apt install php8.0-dom
sudo apt install php8.0-gd -y
sudo apt install php8.0-intl  
sudo apt install php8.0-mbstring -y
# sudo apt install php8.0-simplexml
sudo apt install php8.0-xml 
sudo apt install php8.0-xsl 
sudo apt install php8.0-zip -y
sudo apt-get install php8.0-curl
sudo apt install php8.0-pdo-mysql
sudo apt-get install php8.0-bcmath -y






# Install Composer
curl -sS https://getcomposer.org/installer | sudo php8.0 -- --install-dir=/usr/local/bin --filename=composer

#pull application
cd /var/www/html
sudo git clone {url}

sudo cp .env.example .env


find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;

chown -R www-data:www-data .
chmod -R 755 .
chmod -R 777 storage
chmod -R 777 storage/ *
chmod -R 777 bootstrap/cache

# To test the whole setup
php artisan key:generate
php artisan cache:clear
php artisan config:clear
php artisan config:cache
php artisan optimize:clear
php artisan route:clear
php artisan view:clear


sudo service apache2 restart

