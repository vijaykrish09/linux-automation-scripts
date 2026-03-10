# Linux Administration Automation Suite

A collection of 5 essential Bash scripts for Linux System Administrators to automate daily tasks, monitor system health, and ensure high availability.

## 🛠️ Included Scripts

### 1. User Management (`user_management.sh`)
- **Function:** Automates Linux user creation with home directories and group assignments.
- **Key Feature:** Validates root access and handles password setting securely via `chpasswd`.

### 2. Disk Usage Alert (`disk_usage_alert.sh`)
- **Function:** Monitors physical disk partitions and alerts if usage exceeds 80%.
- **Key Feature:** Intelligently ignores virtual filesystems (tmpfs) to focus on OS health.

### 3. Service Health Check (`system_health_check.sh`)
- **Function:** Scans and maintains core services (SSH, Nginx, Docker, Cron).
- **Key Feature:** **Self-Healing** - Automatically attempts to restart failed services.

### 4. Log Management & Rotation (`log_cleanup.sh`)
- **Function:** Prevents /var/log/messages from filling the disk.
- **Key Feature:** Uses `cat /dev/null` to truncate logs without breaking active process file descriptors.

### 5. Resource Monitor (`resource_monitor.sh`)
- **Function:** Tracks CPU/RAM spikes and identifies "Resource Hog" processes.
- **Key Feature:** Lists the top 5 most expensive processes by PID for rapid troubleshooting.

---

## 🚀 Installation & Execution

1. **Clone the Repo:**
   ```bash
   git clone [https://github.com/your-username/linux-admin-scripts.git](https://github.com/your-username/linux-admin-scripts.git)
   cd linux-admin-scripts

2.**Make Executable:**

chmod +x *.sh
Usage Example:
sudo ./system_health_check.sh

**🛡️ Admin Standards Applied**
Idempotency: Scripts check current system state before execution.

Safety: Critical files are truncated rather than deleted to avoid breaking running services.

Efficiency: Optimized for execution via cron for 24/7 automated management.
