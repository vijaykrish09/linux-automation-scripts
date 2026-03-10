#!/bin/bash

# Ensure root
[[ $EUID -ne 0 ]] && echo "Run as root" && exit 1

read -p "Enter Username: " USERNAME
read -s -p "Enter Password: " PASSWORD
echo ""
read -p "Enter Groups (comma separated): " GROUPS

# Check if user exists
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists!"
    exit 1
fi

# Create user with home directory
useradd -m "$USERNAME"

# Set password securely
echo "$USERNAME:$PASSWORD" | chpasswd

# Assign groups one by one to check for existence
IFS=',' read -ra ADDR <<< "$GROUPS"
for i in "${ADDR[@]}"; do
    if getent group "$i" > /dev/null; then
        usermod -aG "$i" "$USERNAME"
    else
        echo "Warning: Group '$i' does not exist. Skipping..."
    fi
done

echo "User $USERNAME setup complete."
