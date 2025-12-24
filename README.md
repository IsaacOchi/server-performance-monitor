# server-performance-monitor
# Server Performance Statistics Script

A bash script that analyzes and displays basic server performance statistics on any Linux server.
## Features

This script provides the following server statistics:

- **Total CPU Usage** - Current CPU utilization percentage
- **Memory Usage** - Total, used, and free memory with percentage
- **Disk Usage** - Filesystem usage for all mounted drives
- **Top 5 Processes by CPU** - Most CPU-intensive processes
- **Top 5 Processes by Memory** - Most memory-intensive processes

### Additional Statistics (Stretch Goals)

- OS Version and Distribution
- System Uptime
- Load Average (1, 5, and 15 minutes)
- Number of Logged-in Users
- Recent Failed Login Attempts

## Prerequisites

- A Linux-based operating system (Ubuntu, Debian, CentOS, RHEL, etc.)
- Bash shell (pre-installed on most Linux systems)
- Basic system commands: `top`, `free`, `df`, `ps`, `uptime`

## Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR-USERNAME/server-stats-script.git
cd server-stats-script
```

2. Make the script executable:
```bash
chmod +x server-stats.sh
```

## Usage

Run the script with:
```bash
./server-stats.sh
```

For complete statistics including failed login attempts, run with sudo:
```bash
sudo ./server-stats.sh
```

## Sample Output

```
==============================================
SERVER PERFORMANCE STATS
Generated on: Wed Dec 24 10:30:45 EAT 2025
==============================================

CPU USAGE
==============================================
Total CPU Usage: 23.5%

MEMORY USAGE
==============================================
Total Memory: 16Gi
Used Memory: 8.2Gi (51.25%)
Free Memory: 7.8Gi

DISK USAGE
==============================================
Filesystem     Size   Used   Avail  Use%  Mounted on
/dev/sda1      50G    32G    16G    67%   /
/dev/sda2      100G   45G    50G    47%   /home

TOP 5 PROCESSES BY CPU USAGE
==============================================
PID       USER     CPU%   COMMAND
1234      root     12.5   /usr/bin/python3
5678      user     8.3    /usr/lib/firefox
...
```

## How It Works

The script uses several Linux commands to gather system information:

- **CPU Usage**: Parsed from `top` command output
- **Memory Stats**: Retrieved using `free` command
- **Disk Usage**: Collected via `df` command
- **Process Information**: Extracted using `ps aux` with sorting
- **System Info**: Gathered from `/etc/os-release` and `uptime`

## Customization

You can customize the script by:

- Modifying the number of top processes displayed (change `head -n 6`)
- Adjusting color schemes (modify the color variables)
- Adding additional system metrics
- Changing output formatting

## Learning Objectives

This project helps you learn:

- Bash scripting fundamentals
- Linux system monitoring commands
- Text processing with `awk`, `grep`, and `sed`
- Command piping and output redirection
- GitHub version control basics

## Project Requirements

This project fulfills the requirements from [roadmap.sh Server Stats Project](https://roadmap.sh/projects/server-stats):

- ✅ Total CPU usage
- ✅ Total memory usage (Free vs Used including percentage)
- ✅ Total disk usage (Free vs Used including percentage)
- ✅ Top 5 processes by CPU usage
- ✅ Top 5 processes by memory usage
- ✅ Stretch goals: OS version, uptime, load average, logged-in users, failed login attempts

## Contributing

This is a learning project, but suggestions and improvements are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## Troubleshooting

**Permission Denied Error:**
- Make sure the script is executable: `chmod +x server-stats.sh`

**Command Not Found:**
- Ensure you're running on a Linux system with standard utilities installed

**Failed Login Stats Not Showing:**
- Run the script with sudo: `sudo ./server-stats.sh`
- Check if `/var/log/auth.log` or `/var/log/secure` exists on your system

## License

This project is open source and available under the [MIT License](LICENSE).

## Project URL

- **GitHub Repository**: https://github.com/IsaacOchi/server-stats-script

---

⭐ If you found this project helpful, please consider giving it a star on GitHub!
