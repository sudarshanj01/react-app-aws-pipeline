#!/bin/bash

# Install dependencies
npm install

# Build the app
npm run build

# Install PM2 globally if not already installed
npm install -g pm2

# Stop any existing PM2 process with the same name
pm2 stop your-app-name 2>/dev/null || true
pm2 delete your-app-name 2>/dev/null || true

# Start the app with PM2
# For a Next.js app:
pm2 start npm --name "your-app-name" -- start

# For a React app built with Create React App:
# pm2 serve build 3000 --name "your-app-name" --spa

# Save the PM2 process list
pm2 save

# Set PM2 to start on system boot
pm2 startup

# Install Nginx if not already installed
sudo apt-get update
sudo apt-get install -y nginx

# Create Nginx configuration
sudo tee /etc/nginx/sites-available/your-app-name << EOF
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable the Nginx site
sudo ln -s /etc/nginx/sites-available/your-app-name /etc/nginx/sites-enabled/

# Test Nginx configuration
sudo nginx -t

# Reload Nginx to apply changes
sudo systemctl reload nginx

# Display running processes
pm2 list

echo "Deployment completed. Your app should now be accessible via Nginx."
