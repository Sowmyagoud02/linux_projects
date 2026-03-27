#!/bin/bash

# Ask for target IP
read -p "Enter target IP: " ip_address

# Check if IP is empty
if [ -z "$ip_address" ]; then
    echo "No IP entered!"
    exit 1
fi

echo "----------------------------"
echo "Scanning Target: $ip_address"
echo "----------------------------"

# Check if host is alive
echo "[+] Checking if host is alive..."
ping -n 2 "$ip_address" > /dev/null

if [ $? -ne 0 ]; then
    echo "[-] Host is down or unreachable"
    exit 1
else
    echo "[+] Host is UP"
fi

# Run Nmap scan (store result)
echo "[+] Scanning ports..."
scan_result=$(nmap "$ip_address")

# Show full scan (optional but good)
echo "$scan_result"

# Extract open ports
echo "[+] Open Ports:"
open_ports=$(echo "$scan_result" | awk '/open/ {print $1}')

if [ -z "$open_ports" ]; then
    echo "No open ports found"
else
    echo "$open_ports"
fi

echo "----------------------------"
echo "Scan Completed"
echo "----------------------------"