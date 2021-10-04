#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo apt-get install unzip -y

wget https://github.com/yusufluaii/SP01-vagrant-project/raw/zip/landingpage.zip
unzip andinglpage.zip

sudo mkdir /var/www/landingpage

sudo mv landingpage/* /var/www/landingpage


sudo echo '' > /etc/nginx/sites-available/default

sudo cat <<'EOF' > /etc/nginx/sites-available/default

server {
	listen 80 ;
	listen [::]:80 ;

	root /var/www/landingpage;

	index index.js index.html index.htm index.nginx-debian.html;

	server_name sekolahdevops.com www.sekolahdevops.com;

	location / {
		try_files $uri $uri/ =404;

		# Untuk disable cache static assets
        add_header Last-Modified $date_gmt;
        add_header Cache-Control 'no-store, no-cache';
        if_modified_since off;
        expires off;
        etag off;
	}

	location ~ /\.ht {
    deny all;
	}

}
EOF


sudo systemctl reload nginx.service



