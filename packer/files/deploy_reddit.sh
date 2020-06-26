#!/bin/bash

export APPOWNER="reddit"

apt-get install -y git
useradd -U -d /home/$APPOWNER -s /bin/bash $APPOWNER
sudo git clone -b monolith https://github.com/express42/reddit.git /home/$APPOWNER/app
chown -R $APPOWNER:$APPOWNER /home/$APPOWNER
cd /home/$APPOWNER/app && bundle install

echo "[Unit]
Description=Puma HTTP Server
After=network.target
Requires=mongod.service

[Service]
Type=simple
User=$APPOWNER
Group=$APPOWNER
WorkingDirectory=/home/$APPOWNER/app
ExecStart=/usr/local/bin/puma
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/puma.service

systemctl enable puma.service
systemctl start puma.service
