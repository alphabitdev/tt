# 1
apt-get update
apt-get -y upgrade
apt-get -y full-upgrade

# 2
echo "tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0 0" >> /etc/fstab

# 3
locale-gen en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# 4
chmod u+x scripts/newUser.sh
./scripts/newUser.sh alpha

# 5
sudo usermod -aG sudo alpha
sudo usermod -aG admin alpha

# 6
sudo dpkg-statoverride --update --add root admin 4750 /bin/su

# 7
cp ./files/sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd

# 8
cat .files/sysctl.conf >> /etc/sysctl.conf
sysctl --system
service procps start

# 9
echo "# The "order" line is only used by old versions of the C library.
​order bind,hosts
​nospoof on" > /etc/host.conf

# 10
apt install ufw -y
ufw reset
ufw allow 22/tcp
ufw enable

# 11
apt install fail2ban -y
touch /etc/fail2ban/jail.d/ssh.conf
echo "[sshd]

enabled  = true
port     = 22
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 3" > /etc/fail2ban/jail.d/ssh.conf
systemctl restart fail2ban
fail2ban-client status
fail2ban-client status sshd

# 12
apt install ntp -y
sntp --version


# 13
systemctl stop apparmor
apt purge apparmor -y
apt update
apt upgrade -yuf
apt install selinux selinux-utils selinux-basics auditd audispd-plugins -y
sestatus

echo "# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
# enforcing - SELinux security policy is enforced.
# permissive - SELinux prints warnings instead of enforcing.
# disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of these two values:
# default - equivalent to the old strict and targeted policies
# mls     - Multi-Level Security (for military and educational use)
# src     - Custom policy built from source
SELINUXTYPE=default

# SETLOCALDEFS= Check local definition changes
SETLOCALDEFS=0" > /etc/selinux/config