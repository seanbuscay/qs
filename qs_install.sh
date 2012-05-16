#!/bin/bash

# Run the following command to install
# bash ~/quickstart/qs_install.sh

source initvars.sh

echo "${QS_USER} ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/${QS_USER} > /dev/null
sudo chmod 440 /etc/sudoers.d/${QS_USER}

bash ~/quickstart/qs1.sh
bash ~/quickstart/qs2_lamp.sh
bash ~/quickstart/qs3_devenv.sh

cd ~/websites
drush qc --domain=example7.dev
drush qc --domain=example6.dev --makefile=d6.make