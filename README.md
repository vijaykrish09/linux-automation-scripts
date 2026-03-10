# Linux Administration & Automation Suite

A collection of professional Bash scripts designed to automate core System Administration tasks, improve server reliability, and manage system resources.

## 🛠️ Scripts Included

### 1. User Management (`user_management.sh`)
**Purpose:** Streamlines the onboarding process by automating user creation.
- **Key Features:** Validates root privileges, creates home directories, sets passwords, and assigns supplementary groups.
- **Value:** Ensures consistency in user environment setups and prevents manual configuration errors.

### 2. Disk Usage Monitor (`disk_usage_alert.sh`)
**Purpose:** Proactive monitoring of filesystem health.
- **Key Features:** Filters out virtual filesystems (tmpfs/dev), targets major OS disks, and provides alerts when partitions exceed 80% capacity.
- **Value:** Prevents system outages caused by "Disk Full" errors on critical partitions like `/` or `/var`.

### 3. System Health & Self-Healing (`system_health_check.sh`)
**Purpose:** Monitors and maintains high availability for core infrastructure services.
- **Key Features:** Scans status of critical services (SSH, Cron, Nginx, Docker). If a service is down, the script attempts an automated restart.
- **Value:** Reduces downtime and manual intervention by implementing "self-healing" logic for major system processes.

### 4. Log Management & Cleanup (`log_cleanup.sh`)
**Purpose:** Manages system log growth to prevent disk saturation.
- **Key Features:** Compresses the current `/var/log/messages` into a timestamped `.gz` archive and clears the active log file without restarting services.
- **Value:** Maintains log history for auditing while immediately reclaiming disk space.

---

## 🚀 How to Use

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/linux-automation.git](https://github.com/your-username/linux-automation.git)
   cd linux-automation
2. **Grant execution permissions:**


chmod +x *.sh
Run a script (requires root/sudo):


sudo ./log_cleanup.sh

**🧠 Admin Best Practices Applied**
Process-Safe Log Clearing: Uses cat /dev/null instead of rm. This ensures that any process currently writing to the log file (like rsyslog) doesn't lose its file descriptor.

Idempotency: Scripts check for existing users or services before attempting changes.

Automation Ready: All scripts are designed to be easily scheduled via crontab for 24/7 monitoring.
