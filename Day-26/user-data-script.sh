#!/bin/bash
# User data script to install and start Nginx

# Update packages
apt update

# Install Nginx
apt install -y nginx

# Start and enable Nginx service
systemctl start nginx
systemctl enable nginx

# Optional: Create a simple custom index page
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to xFusion Web Server</title>
</head>
<body>
    <h1>xFusion Web Server is Running!</h1>
    <p>This server was automatically configured during launch.</p>
    <p>Server: $(hostname)</p>
    <p>Date: $(date)</p>
</body>
</html>
EOF

# Restart Nginx to apply changes
systemctl restart nginx