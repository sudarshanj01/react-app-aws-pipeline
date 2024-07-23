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

# Check if the build directory exists
if [ -d "build" ]; then
  # Run the serve command using nohup
  nohup serve -s build -l 80 > /dev/null 2>&1 &
else
  echo "Build directory does not exist. Please ensure your application is built."
  exit 1
fi
