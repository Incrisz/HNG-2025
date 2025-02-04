# HNG-2025 Readme for stage1

# Setting Up PHP 8.0 with Apache on Ubuntu

## Prerequisites
Ensure you have a fresh Ubuntu installation with `sudo` privileges.

---

## Step 1: Update System Packages
Before installing new software, update your system packages:
```sh
sudo apt update && sudo apt upgrade -y
```

---

## Step 2: Install Necessary Packages
Install essential utilities like `unzip` and `p7zip`:
```sh
sudo apt-get install unzip -y
sudo apt-get install p7zip -y
```

---

## Step 3: Install Apache Web Server
Install the Apache web server:
```sh
sudo apt install apache2 -y
```
Ensure Apache is running:
```sh
sudo systemctl status apache2
```
If Apache is not running, start it:
```sh
sudo systemctl start apache2
```

---

## Step 4: Install PHP 8.0
First, add the `ondrej/php` repository, which provides multiple PHP versions:
```sh
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
```
Now, install PHP 8.0:
```sh
sudo apt install php8.0 -y
```
Verify the installation:
```sh
php -v
```

---

## Step 5: Install PHP Extensions
Install necessary PHP extensions required for the project:
```sh
sudo apt install php8.0-dom php8.0-gd php8.0-intl php8.0-mbstring php8.0-xml php8.0-xsl php8.0-zip -y
sudo apt-get install php8.0-curl php8.0-pdo-mysql php8.0-bcmath -y
```

---

## Step 6: Set Up API Directory
Navigate to the web root directory and create an `/api` directory:
```sh
cd /var/www/html/
sudo mkdir /api
cd /api
```
Create the `classify-number.php` file:
```sh
sudo nano classify-number.php
```

Add the following sample code to `classify-number.php`:
```php
paste the classify-number.php code inside
```
Save the file (`CTRL + X`, then `Y`, then `ENTER`).

Test the API by visiting:
```
http://18.133.157.28/api/classify-number.php?number=371
```

---

## Step 7: Configure Apache
Navigate to the Apache configuration directory:
```sh
cd /etc/apache2/sites-available/
```
Remove the default Apache configuration file:
```sh
sudo rm 000-default.conf
```
Create a new `000-default.conf` file:
```sh
sudo nano 000-default.conf
```

Add the following configuration:
```apache
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    <Directory /var/www/html/>
        AllowOverride All
        Require all granted
        Options Indexes FollowSymLinks
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Save the file (`CTRL + X`, then `Y`, then `ENTER`).

Restart Apache to apply changes:
```sh
sudo systemctl restart apache2
```

---

## Conclusion
You have successfully set up an Apache server with PHP 8.0 and a sample API. Test the setup using the provided API endpoint.

For troubleshooting, check Apache logs:
```sh
sudo tail -f /var/log/apache2/error.log
```


when uploading use

http://18.133.157.28/api/classify-number.php  # without parameter

https://github.com/Incrisz/HNG-2025