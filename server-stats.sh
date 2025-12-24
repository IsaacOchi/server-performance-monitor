#!/bin/bash

# server-stats.sh - A script to analyze basic server performance statistics
# This script provides CPU, memory, disk usage, and top processes information

# Color codes for better readability (optional)
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print a separator line
print_separator() {
    echo "=============================================="
}

# Function to print section headers
print_header() {
    echo -e "${BLUE}$1${NC}"
    print_separator
}

# Main header
echo ""
print_separator
echo -e "${GREEN}SERVER PERFORMANCE STATS${NC}"
echo "Generated on: $(date)"
print_separator
echo ""

# 1. TOTAL CPU USAGE
print_header "CPU USAGE"
# Using top command to get CPU usage
# -bn1: batch mode, one iteration
# grep "Cpu(s)": find the CPU line
# awk: extract the idle percentage and calculate usage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Total CPU Usage: ${cpu_usage}%"
echo ""

# 2. MEMORY USAGE
print_header "MEMORY USAGE"
# Using free command to get memory stats
# -h: human-readable format (GB, MB, etc.)
# Read the values into variables
total_mem=$(free -h | grep "Mem:" | awk '{print $2}')
used_mem=$(free -h | grep "Mem:" | awk '{print $3}')
free_mem=$(free -h | grep "Mem:" | awk '{print $4}')

# Calculate percentage (using free -m for MB values to do math)
total_mem_mb=$(free -m | grep "Mem:" | awk '{print $2}')
used_mem_mb=$(free -m | grep "Mem:" | awk '{print $3}')
mem_percentage=$(awk "BEGIN {printf \"%.2f\", ($used_mem_mb/$total_mem_mb)*100}")

echo "Total Memory: $total_mem"
echo "Used Memory: $used_mem (${mem_percentage}%)"
echo "Free Memory: $free_mem"
echo ""

# 3. DISK USAGE
print_header "DISK USAGE"
# Using df command to show disk usage for root filesystem
# -h: human-readable format
echo "Filesystem     Size   Used   Avail  Use%  Mounted on"
df -h | grep -E '^/dev/' | awk '{printf "%-14s %-6s %-6s %-6s %-6s %s\n", $1, $2, $3, $4, $5, $6}'
echo ""

# 4. TOP 5 PROCESSES BY CPU USAGE
print_header "TOP 5 PROCESSES BY CPU USAGE"
echo "PID       USER     CPU%   COMMAND"
ps aux --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "%-9s %-8s %-6s %s\n", $2, $1, $3, $11}'
echo ""

# 5. TOP 5 PROCESSES BY MEMORY USAGE
print_header "TOP 5 PROCESSES BY MEMORY USAGE"
echo "PID       USER     MEM%   COMMAND"
ps aux --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf "%-9s %-8s %-6s %s\n", $2, $1, $4, $11}'
echo ""

# STRETCH GOALS - Additional Statistics
print_header "ADDITIONAL SYSTEM INFORMATION"

# OS Version
echo "OS Version:"
if [ -f /etc/os-release ]; then
    cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2
else
    uname -s -r
fi
echo ""

# System Uptime
echo "System Uptime:"
uptime -p
echo ""

# Load Average (1, 5, 15 minutes)
echo "Load Average (1m, 5m, 15m):"
uptime | awk -F'load average:' '{print $2}'
echo ""

# Logged in Users
echo "Logged in Users:"
who | wc -l
echo ""

# Failed Login Attempts (last 10)
echo "Recent Failed Login Attempts:"
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 5 | wc -l
    echo "(Check auth.log for details)"
elif [ -f /var/log/secure ]; then
    grep "Failed password" /var/log/secure 2>/dev/null | tail -n 5 | wc -l
    echo "(Check secure log for details)"
else
    echo "Log file not accessible or not found"
fi
echo ""

print_separator
echo "End of Report"
print_separator
