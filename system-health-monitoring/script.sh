#!/bin/bash

#to check the memory usage
memory_usage=$(free -h)

#to check disk usage
disk_usage=$(df -h)

#to check top processes
top_processes=$(ps aux --sort=-%cpu | head -n 6)
#shows top 6 cpu consuming processes

#to check uptime
uptime=$(uptime)

echo "System Health Report"
echo "--------------------"
echo "Memory Usage:"
echo "$memory_usage"
echo "Disk Usage:"
echo "$disk_usage"
echo "Top Processes:"
echo "$top_processes"
echo "System Uptime:"
echo "$uptime"