#!/bin/bash

# Create virtual host file for Laravel application
sudo cat <<EOT >> /etc/apache2/sites-available/hng.conf
<VirtualHost *:80>
    ServerName hng.bmp.com.ng
    ServerAdmin webmaster@localhost

    DocumentRoot /var/www/html/hng

    <Directory /var/www/html/hng>
        AllowOverride All
        Require all granted
        Options Indexes FollowSymLinks
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/hng_error.log
    CustomLog ${APACHE_LOG_DIR}/hng_access.log combined

    # Redirect HTTP to HTTPS
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^/?(.*) https://%{SERVER_NAME}/$1 [R=301,L]
</VirtualHost>

<IfModule mod_ssl.c>
<VirtualHost *:443>
    ServerName hng.bmp.com.ng
    ServerAdmin webmaster@localhost

    DocumentRoot /var/www/html/hng

    <Directory /var/www/html/hng>
        AllowOverride All
        Require all granted
        Options Indexes FollowSymLinks
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/hng_ssl_error.log
    CustomLog ${APACHE_LOG_DIR}/hng_ssl_access.log combined

    SSLEngine on

    # Temporary dummy paths — to avoid Apache crash before certbot runs
    SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key

</VirtualHost>
</IfModule>

EOT






#test config
sudo apachectl configtest



#enable
sudo a2ensite hng.conf
sudo a2enmod ssl rewrite
sudo systemctl reload apache2

sudo apt install certbot python3-certbot-apache
sudo certbot --apache -d hng.bmp.com.ng




