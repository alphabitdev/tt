#! /bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $(basename $0) USERNAME (KEY_URL)"
    exit 1
fi
if [ $# -ne 2 ]
then
    KEY_URL="https://raw.githubusercontent.com/alphabitdev/init/master/key.pub"
else
    KEY_URL=$2
fi
USER=$1
sudo adduser "$USER"
cd /home/"$USER"
mkdir /home/"$USER"/.ssh
touch /home/"$USER"/.ssh/authorized_keys
wget "$KEY_URL"
cat key.pub >> /home/"$USER"/.ssh/authorized_keys
rm key.pub
chown -R "$USER":"$USER" /home/"$USER"/.ssh
chmod 600 /home/"$USER"/.ssh/authorized_keys
chmod 700 /home/"$USER"/.ssh