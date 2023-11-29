#!/bin/bash

set -x
DB_USER="snipeituser"
DB_PASS="root"
DB_NAME="snipeitdb" 
export DEBIAN_FRONTEND=noninteractive
# Update and install packages without prompts
sudo apt update -y
sudo apt install -y apache2 mariadb-server mariadb-client ufw git

# Start and enable services
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mariadb
sudo systemctl enable mariadb

# ALLOW PORTS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload

# Enable Apache modules
sudo a2enmod rewrite
sudo systemctl restart apache2

# INSTALL PHP
sudo apt install -y php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath

# Install Composer
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# CREATE DATABASE FOR SNIP-IT
sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Clone Snipe-IT repository
sudo git clone https://github.com/snipe/snipe-it /var/www/snipe-it
cd /var/www/snipe-it

# Copy environment file
sudo cp .env.example .env

# Update .env file with database credentials
sudo sed -i "s|^\\(DB_DATABASE=\\).*|\\1$DB_NAME|" .env
sudo sed -i "s|^\\(DB_USERNAME=\\).*|\\1$DB_USER|" .env
sudo sed -i "s|^\\(DB_PASSWORD=\\).*|\\1$DB_PASS|" .env
sudo sed -i "s|^\\(APP_URL=\\).*|\\1|" .env

# Set ownership and permissions
sudo chown -R www-data:www-data /var/www/snipe-it
sudo chmod -R 755 /var/www/snipe-it

# Install Composer dependencies without prompts
COMPOSER_ALLOW_SUPERUSER=1 sudo composer install --no-dev --prefer-source --no-plugins --no-scripts -q

# Generate application key
yes | sudo php artisan key:generate

# Configure Apache virtual host
sudo a2dissite 000-default.conf
sudo cat << EOF | sudo tee /etc/apache2/sites-available/snipe-it.conf
<VirtualHost *:80>
  ServerName snipe-it.syncbricks.com
  DocumentRoot /var/www/snipe-it/public
  <Directory /var/www/snipe-it/public>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    allow from all
  </Directory>
</VirtualHost>
EOF

# Enable Apache virtual host
sudo a2ensite snipe-it.conf

# Set ownership and permissions for storage directory
sudo chown -R www-data:www-data storage
sudo chmod -R 755 storage

# Restart Apache
sudo systemctl restart apache2
