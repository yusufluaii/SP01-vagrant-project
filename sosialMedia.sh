#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo apt-get install php-fpm -y




sudo apt-get install php-mysql -y
sudo apt-get install mariadb-server -y




sudo apt-get install unzip -y

wget https://github.com/yusufluaii/SP01-vagrant-project/raw/zip/sosmed.zip
unzip sosmed.zip

sudo mkdir /var/www/pesbuk
sudo mv sosmed/* /var/www/pesbuk

sudo echo '' >  /etc/nginx/sites-available/default

sudo cat <<'EOF' > /etc/nginx/sites-available/default

server {
	listen 80 ;
	listen [::]:80 ;

	root /var/www/pesbuk;

	index index.php index.html index.htm index.nginx-debian.html;

	server_name pesbuk.com www.pesbuk.com;

	location / {
		try_files $uri $uri/ =404;

		# Untuk disable cache static assets
        add_header Last-Modified $date_gmt;
        add_header Cache-Control 'no-store, no-cache';
        if_modified_since off;
        expires off;
        etag off;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	}

	location ~ /\.ht {
    deny all;
	}

}
EOF


# 1. bikin username dan password
sudo mysql -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';"
sudo mysql -e "grant all privileges on *.* to 'devopscilsy'@'localhost'"
sudo mysql -e "flush privileges"
sudo mysql -e "CREATE DATABASE dbsosmed" 
# 2.migrasi dump sql
sudo mysql -u devopscilsy -p1234567890 dbsosmed < /var/www/pesbuk/dump.sql


sudo systemctl reload php7.0-fpm.service
sudo systemctl reload nginx.service



