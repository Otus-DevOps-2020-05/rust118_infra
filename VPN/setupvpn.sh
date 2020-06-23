#!/bin/bash

sudo echo "deb https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo echo "deb https://repo.pritunl.com/stable/apt bionic main" > /etc/apt/sources.list.d/pritunl.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

sudo apt update
sudo apt -y install pritunl mongodb-org

sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod
