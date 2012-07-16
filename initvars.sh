#!/bin/bash

# This should be your mysql root user password.  
QS_PASS=quickstart
# This should be your Linux login name.  Also the name of your home directory.
QS_USER=$USER
# If true, all out bound email will be logged rather than actually sent.  Helpful in a dev enviroment.  
# Set false to not set this up.
EMAIL_CATCHER=TRUE
# This is your default tld such as .dev or dev1.ws
DTLD=.dev