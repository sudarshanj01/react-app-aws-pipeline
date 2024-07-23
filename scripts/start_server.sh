#!/bin/bash
# Install Node.js and serve if not already installed

# Check if Node.js is installed
if ! [ -x "$(command -v node)" ]; then
  curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
  sudo yum install -y nodejs
fi

# Check if serve is installed
if ! [ -x "$(command -v serve)" ]; then
  sudo npm install -g serve
fi

# Navigate to the application directory
cd /var/www/html
sudo serve -s build -l 80
