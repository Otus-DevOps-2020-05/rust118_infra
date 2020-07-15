#!/bin/bash

APPOWNER="appuser"
APPOWNERHOME="/home/$APPOWNER"
APPDIR="$APPOWNERHOME/app"

apt-get install -y git
useradd -U -d $APPOWNERHOME -s /bin/bash $APPOWNER
sudo git clone -b monolith https://github.com/express42/reddit.git $APPDIR
chown -R $APPOWNER:$APPOWNER $APPDIR
cd $APPOWNERHOME && bundle install

echo "[Unit]
Description=Puma HTTP Server
After=network.target
Requires=mongod.service

[Service]
Type=simple
User=$APPOWNER
Group=$APPOWNER
WorkingDirectory=$APPDIR
ExecStart=/usr/local/bin/puma
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/puma.service

systemctl enable puma.service
systemctl start puma.service
