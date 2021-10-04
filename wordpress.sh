#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo apt-get install php-fpm -y
sudo apt-get install php-mysql -y
sudo apt-get install mariadb-server -y
sudo apt-get install unzip -y


wget https://github.com/yusufluaii/SP01-vagrant-project/raw/zip/wordpress.zip
unzip wordpress.zip

sudo mkdir /var/www/wordpress
sudo mv wordpress/* /var/www/wordpress


sudo echo '' > /etc/nginx/sites-available/default

sudo cat <<'EOF' > /etc/nginx/sites-available/default

server {
	listen 80 ;
	listen [::]:80 ;

	root /var/www/wordpress;

	index index.php index.html index.htm index.nginx-debian.html;

	server_name wordpress.com www.wordpress.com;

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

# username dan password
sudo mysql -e "create user 'yusufluai'@'localhost' identified by 'yusufluai123';"
sudo mysql -e "grant all privileges on *.* to 'yusufluai'@'localhost'"
sudo mysql -e "flush privileges"
sudo mysql -e "create database wordpressDB"

#dump sql
sudo mysql -u yusufluai -pyusufluai123 wordpressDB < /var/www/wordpress/dump.sql





sudo systemctl reload php7.0-fpm.service
sudo systemctl reload nginx.service



