#!/bin/bash

# Update packages
apt update -y

# Install Apache2
apt install apache2 -y

# Start Apache2 service
systemctl start apache2

# Enable Apache2 on boot
systemctl enable apache2

# Add test web page
echo "<h1>Hello from Sushant's DevOps EC2</h1>" > /var/www/html/index.html
