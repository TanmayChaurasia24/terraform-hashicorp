#!/bin/bash

sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Nginx installed and started successfully."