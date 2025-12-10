#!/bin/bash

# Enable Root SSH Login Script
# This script configures SSH to allow root login with password authentication

# Set password for root user
# Note: This command is interactive. You may need to run it manually or use:
# echo 'root:yourpassword' | sudo chpasswd
sudo passwd root

# Backup the original SSH config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Enable PermitRootLogin
# If the setting exists, uncomment and set to yes
# If it doesn't exist, add it
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
    echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config
fi

# Enable PasswordAuthentication
# If the setting exists, uncomment and set to yes
# If it doesn't exist, add it
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
if ! grep -q "^PasswordAuthentication" /etc/ssh/sshd_config; then
    echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
fi

# Restart SSH service
sudo systemctl restart ssh

echo "SSH configuration updated. Root login and password authentication enabled."
echo "Original config backed up to /etc/ssh/sshd_config.backup"
