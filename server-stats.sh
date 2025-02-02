#!/bin/bash

# Monitor CPU usage
get_cpu_usage() {
  echo "CPU Usage:"
  mpstat 1 1 | awk '$NF ~ /[0-9.]+/ { print 100 - $NF"% used" }'
}

# Display memory usage
get_memory_usage() {
  echo "Memory Usage:"
  free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'
}

# Check disk usage
get_disk_usage() {
  echo "Disk Usage:"
  df -h | grep '^/dev/' | awk 'END{print  "Used: "$3", Free: "$4", Usage: "$5}'
}

# List top 5 processes by CPU usage
get_top_cpu_processes() {
  echo "Top 5 Processes by CPU Usage:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

# List top 5 processes by memory usage
get_top_mem_processes() {
  echo "Top 5 Processes by Memory Usage:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
}

# Additional system stats
get_extra_stats() {
  echo "System Uptime:"
  uptime -p
  echo "Load Average:"
  uptime | awk -F 'load average:' '{print $2}'
}

# Main function to execute all monitoring functions
main() {
  echo "Server Performance Stats"
  echo "-------------------------"
  get_cpu_usage
  get_memory_usage
  get_disk_usage
  get_top_cpu_processes
  get_top_mem_processes
  get_extra_stats
}

# Call main function
main
