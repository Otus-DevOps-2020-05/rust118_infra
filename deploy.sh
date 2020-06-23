#!/bin/bash

if ![ -x /usr/bin/git ] then
    sudo apt-get install -y git
fi

git clone -b monolith https://github.com/express42/reddit.git && cd reddit && bundle install && puma -d
