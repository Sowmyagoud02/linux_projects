#!/bin/bash

# Ask for file
read -p "Enter log file name: " file_name

# Check if file exists
if [ ! -f "$file_name" ]; then
    echo "File not found!"
    exit 1
fi

echo "------ Log Analysis Report ------"

# Total lines
total_lines=$(wc -l < "$file_name")
echo "Total lines: $total_lines"

# Failed login attempts
failed_attempts=$(grep -ci "LOGIN_FAILED" "$file_name")
echo "Failed login attempts: $failed_attempts"

# Top attacking IP
top_ip=$(grep -i "LOGIN_FAILED" "$file_name" \
    | awk '{print $1}' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 1)

top_ip_count=$(echo "$top_ip" | awk '{print $1}')
top_ip_addr=$(echo "$top_ip" | awk '{print $2}')

echo "Top Attacker IP: $top_ip_addr ($top_ip_count attempts)"

# Top attacked user (case normalized)
top_user=$(grep -i "LOGIN_FAILED" "$file_name" \
    | awk '{print tolower($3)}' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 1)

top_user_count=$(echo "$top_user" | awk '{print $1}')
top_user_name=$(echo "$top_user" | awk '{print $2}')

echo "Most Targeted User: $top_user_name ($top_user_count attempts)"

# Alert
if [ "$failed_attempts" -gt 3 ]; then
    echo "⚠️ ALERT: Possible brute force attack detected!"
fi

echo "--------------------------------"