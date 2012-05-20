#!/bin/bash

DRUSH_VERSION="7.x-5.1"
cd ~

source ~/quickstart/.local/initvars.sh

# ################################################################################ Configure phpmyadmin

# show hex data on detail pages.
echo "
# Show 1000 rows instead of 30 by default
\$cfg['MaxRows'] = 1000;
# Show BLOB data as a string not hex.
\$cfg['DisplayBinaryAsHex'] = false;
# Show BLOB data in row detail pages.
\$cfg['ProtectBinary'] = false;
# Show BLOB data on table browse pages.  Hack to hardcode all requests.
\$_REQUEST['display_blob'] = true;
" | sudo tee -a /etc/phpmyadmin/config.inc.php

# never log me out!
echo "
/*
* Prevent timeout for a year at a time.
* (seconds * minutes * hours * days * weeks)
*/
\$cfg['LoginCookieValidity'] = 60*60*24*7*52;
ini_set('session.gc_maxlifetime', \$cfg['LoginCookieValidity']);
" | sudo tee -a /etc/phpmyadmin/config.inc.php


# ################################################################################ Drupal sites
# Create folder for websites to live in
mkdir ~/websites

echo "This is where Quickstart websites go.

Quickstart includes some command line scripts to automate site creation.

To create a site (dns, apache, code, database, and install):

  1) Start a terminal (top left icon, click the black box with a [>_] )

  2) Paste in this command (don't include the $)
    $ drush quickstart-create --domain=newsite.dev
         or
    $ drush qc --domain=newsite.dev

To delete a site:
  $ drush quickstart-delete --domain=newsite.dev
         or
  $ drush qd --domain=newsite.dev

For more information:
  $ drush help quickstart-create
  $ drush help quickstart-destroy
  Or goto http://drupal.org/node/819398" > ~/websites/README.txt


# ################################################################################ Drush
# Install drush

git clone http://git.drupal.org/project/drush.git
cd ~/drush
git checkout $DRUSH_VERSION

#mdrmike @FIXME (don't need once pear install works):
chmod u+x ~/drush/drush
sudo ln -s ~/drush/drush /usr/local/bin/drush

# Install drush make and drush site-install6
mkdir ~/.drush
cd ~/.drush
cd ~

# Install drush quickstart
ln -s ~/quickstart/drush ~/.drush/quickstart
cp ~/quickstart/make_templates/*.make ~/websites

# ################################################################################ Replace localhost/index.html
# Add interesting default document for localhost
sudo rm /var/www/index.html
sudo chmod 770 /var/www
cp ~/quickstart/config/index.php /var/www/index.php
sudo chmod 750 /var/www/index.php


# ################################################################################ Command line shortcuts (bash aliases)

# Don't sudo here...
#cat ~/quickstart/config/qs_bash_aliases >> ~/.bash_aliases



# ################################################################################ Email catcher

# Configure email collector
mkdir /home/${QS_USER}/websites/logs/mail
chmod -R 770 /home/${QS_USER}/websites/logs/mail
sudo sed -i 's/;sendmail_path =/sendmail_path=\/home\/${QS_USER}\/quickstart\/config\/sendmail.php/g' /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
chmod +x /home/${QS_USER}/quickstart/config/sendmail.php



# ################################################################################ XDebug Debugger/Profiler

# Configure xdebug - installed 2.1 from apt
mkdir /home/${QS_USER}/websites/logs/profiler
echo "
xdebug.remote_enable=on
xdebug.remote_handler=dbgp
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.profiler_enable=0
xdebug.profiler_enable_trigger=1
xdebug.profiler_output_dir=/home/${QS_USER}/websites/logs/profiler
" | sudo tee -a /etc/php5/conf.d/xdebug.ini > /dev/null


# ################################################################################ Install a web-based profile viewer
cd ~/websites/logs/profiler

wget -nv -O webgrind.zip http://webgrind.googlecode.com/files/webgrind-release-1.0.zip
unzip webgrind.zip
rm webgrind.zip

# Setup Web server
echo "127.0.0.1 webgrind

" | sudo tee -a /etc/hosts > /dev/null

echo "Alias /profiler /home/${QS_USER}/websites/logs/profiler/webgrind

<Directory /home/${QS_USER}/websites/logs/profiler/webgrind>
  Allow from All
</Directory>
" | sudo tee /etc/apache2/conf.d/webgrind > /dev/null

chmod -R 770 /home/${QS_USER}/websites/logs/profiler


# ################################################################################ XHProf profiler (Devel Module)
# Adapted from: http://techportal.ibuildings.com/2009/12/01/profiling-with-xhprof/

# supporting packages
sudo apt-get -yq install graphviz

# get it
cd ~
wget -nv http://pecl.php.net/get/xhprof-0.9.2.tgz
tar xvf xhprof-0.9.2.tgz
mv xhprof-0.9.2 /home/${QS_USER}/websites/logs/xhprof
rm xhprof-0.9.2.tgz
rm package.xml

# build and install it
cd /home/${QS_USER}/websites/logs/xhprof/extension/
phpize
./configure
make
sudo make install

# configure php
echo "
[xhprof]
extension=xhprof.so
xhprof.output_dir=\"/home/${QS_USER}/websites/logs/xhprof\"
" | sudo tee /etc/php5/conf.d/xhprof.ini > /dev/null

# configure apache
echo "Alias /xhprof /home/${QS_USER}/websites/logs/xhprof/xhprof_html

<Directory /home/${QS_USER}/websites/logs/profiler/xhprof/xhprof_html>
  Allow from All
</Directory>
" | sudo tee /etc/apache2/conf.d/xhprof > /dev/null

chmod -R 770 /home/${QS_USER}/websites/logs/xhprof


# ################################################################################ Restart apache
sudo apache2ctl restart


# ################################################################################ Squid caching of ftp.drupal.org

cd ~
sudo apt-get update

# Install caching proxy server
sudo apt-get -y install squid3

echo "http_proxy=\"http://localhost:3128\"" | sudo tee -a /etc/environment > /dev/null

echo "
# fix for git 417 errors
ignore_expect_100 on

# Quickstart
acl drushservers dstdomain ftp.drupal.org
cache allow drushservers
cache deny all

# don't wait to finish requests before shutting down.  Do it now!
shutdown_lifetime 0 seconds
" | sudo tee -a /etc/squid3/squid.conf

echo "*** REBOOT TO TAKE EFFECT ***"

