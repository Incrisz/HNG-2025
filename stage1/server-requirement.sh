
# Update packages and install necessary packages
sudo apt update
sudo apt-get install unzip
sudo apt-get install p7zip -y

sudo apt install apache -y


# Add the ondrej/php repository and install PHP 8.0
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt install php8.0 -y

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



cd /var/www/html/
mkdir /api
cd /api
nano classify-number.php

run http://18.133.157.28/api/classify-number.php?number=371 

cd /etc/apache2/sites-available

rm 000-default.conf

nano 000-default.conf