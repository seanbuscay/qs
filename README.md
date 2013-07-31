# QS

A minor fork of the Drupal Quickstart: Pre-made Development Environment with custom environment variables such as user name and password.

NOTE: For a Pre-made Drupal Development Environment I recommend my more recent project @ https://github.com/seanbuscay/drupal-server .

## About this Fork

This fork is an experiment in settting up Quickstart and using its modules in an already existing Ubuntu Unity enviroment.  
The purpose is to let devs already using Ubuntu for their main OS to use Quickstart without starting up a VM.

## Install

Note: This will install/re-install php/mysql/apache and other tools used in Drupal development.  
If you don't want to install the lamp stack on top of your own, then comment out "bash ~/quickstart/qs2_lamp.sh" within qs_install.sh.

#### Run:

        cd ~
        sudo apt-get -y install git wget curl
        git clone git://github.com/seanbuscay/qs.git quickstart
        bash ~/quickstart/qs_prep.sh
        
#### Edit: ~/quickstart/local/initvars.sh  

Change the QS_PASS=quickstart & QS_USER=quickstart to your user name and your mysql password for the root mysql user.

#### Edit ~/quickstart/drush/local/quickstartvars.inc

Change the QS_PASS & QS_USER to your user name and your mysql password for the root mysql user.

#### Run:
        
        bash ~/quickstart/qs_install.sh


## Canonical Drupal Quickstart

The primary and canonical Drupal Quickstart project is located here: http://drupal.org/project/quickstart

Quickstart is a pre-made downloadable development environment for Drupal.

It provides "state-of-the-art" development and testing tools, without requiring users to:

1. hack up their personal computer,
2. spend time learning how to hack up their personal computer

The Drupal Quickstart project is a most excellent tool for Drupal developers.  
You can download a fully ready to run Drupal development environment from its project page.

See:

1. http://drupal.org/project/quickstart
2. http://drupal.org/node/788080
3. http://groups.drupal.org/quickstart-drupal-development-environment
4. http://www.youtube.com/user/drupalquickstart

## File List

Maybe later :) -
