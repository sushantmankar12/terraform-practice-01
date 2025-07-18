#!/bin/bash

# Update the package list
apt update -y

# Install Apache2
apt install apache2 -y

# Start the Apache2 service
systemctl start apache2

# Enable Apache2 to start on boot
systemctl enable apache2

# Add custom web page
echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
