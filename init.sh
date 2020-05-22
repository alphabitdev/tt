# 1
#apt-get update
#apt-get -y upgrade
#apt-get -y full-upgrade

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
chmod u+x scripts/newSSHUser.sh
./scripts/newSSHUser.sh alpha

# 5
sudo usermod -aG sudo alpha
sudo usermod -aG admin alpha

# 6
sudo dpkg-statoverride --update --add root admin 4750 /bin/su

# 7
cp ./files/sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd

# 8
cat ./files/sysctl.conf >> /etc/sysctl.conf
sysctl --system
service procps start

# 9
apt install ufw -y
ufw allow 22/tcp
ufw enable

# 10
apt install fail2ban -y
cp ./files/sshjail.conf /etc/fail2ban/jail.d/ssh.conf
systemctl restart fail2ban
fail2ban-client status
fail2ban-client status sshd

# 11
apt install ntp -y
sntp --version


cmp --silent ./files/sshd_config /etc/ssh/sshd_config && echo "sshd_config copied" || echo "sshd_config IS NOT COPIED!!!!"
cmp --silent ./files/sshjail.conf /etc/fail2ban/jail.d/ssh.conf && echo "sshjail.conf copied" || echo "sshjail.conf IS NOT COPIED!!!!"

echo "sudo reboot"
su alpha
