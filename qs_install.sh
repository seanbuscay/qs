#!/bin/bash

# Please make sure you read the README file first.

# Run the following command to install
# bash ~/quickstart/qs_install.sh

# Include our one time init varaibles.  Make sure you have already edited this file.
source initvars.sh

# Attempt to add your username as a sudo user who does not need to enter a password.
# This is a security issue if you are on any public network.  
echo "${QS_USER} ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/${QS_USER} > /dev/null
sudo chmod 440 /etc/sudoers.d/${QS_USER}

bash ~/quickstart/qs1.sh
bash ~/quickstart/qs2_lamp.sh
bash ~/quickstart/qs3_devenv.sh

cd ~/websites
drush qc --domain=example7.dev
drush qc --domain=example6.dev --makefile=d6.make