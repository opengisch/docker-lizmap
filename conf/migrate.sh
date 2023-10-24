#!/bin/bash
set -e
#generate config file
VARCONFIG="/var/www/lizmap/var/config"
PREVIOUSCONFIG="/var/www/lizmap/previous-config"

if [[ ! -d $VARCONFIG ]]; then
  # the var volume is empty, let's fill it with default configuration files and missing directories
  echo "Creating Config file in /var"
  cp -avr /var/www/lizmap/var_install/*  /var/www/lizmap/var
fi

if [[ -d $PREVIOUSCONFIG ]]; then
  # there is a volume containing the installer.ini.php file and the jauth.db file of
  # a previous version of Lizmap, let's install it.
  if [[ -f $PREVIOUSCONFIG/installer.ini.php ]]; then
    cp $PREVIOUSCONFIG/installer.ini.php $VARCONFIG/
  fi
  if [[ -f $PREVIOUSCONFIG/localconfig.ini.php ]]; then
    cp $PREVIOUSCONFIG/localconfig.ini.php $VARCONFIG/
  fi
  if [[ -f $PREVIOUSCONFIG/liveconfig.ini.php ]]; then
    cp $PREVIOUSCONFIG/liveconfig.ini.php $VARCONFIG/
  fi
  if [[ -f $PREVIOUSCONFIG/profiles.ini.php ]]; then
    cp $PREVIOUSCONFIG/profiles.ini.php $VARCONFIG/
  fi
  if [[ -f $PREVIOUSCONFIG/lizmapConfig.ini.php ]]; then
    cp $PREVIOUSCONFIG/lizmapConfig.ini.php $VARCONFIG/
  fi
  if [[ -f $PREVIOUSCONFIG/jauth.db ]]; then
    cp $PREVIOUSCONFIG/jauth.db /var/www/lizmap/var/db/
  fi
fi

# launch the configurator. In case this is an upgrade of Lizmap, it will
# launch the migration of configuration file if needed
# php /var/www/lizmap/install/configurator.php

# activate extra modules
# php /var/www/lizmap/install/configurator.php saml
# php /var/www/lizmap/install/configurator.php samladmin

# launch the installer, it will launch modules/lizmap installers if
# lizmap/var was empty or it will launch module updaters if needed..
php /var/www/lizmap/install/installer.php

# remove cache and temporary files, to be sure that they will be regenerated
# with the updated configuration and source files
/var/www/lizmap/install/clean_vartmp.sh
#set-rights
/var/www/lizmap/install/set_rights.sh www-data www-data
