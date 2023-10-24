#!/bin/bash
set -e

echo "LE_on:" $LE_on
echo "LE_staging:" $LE_staging
echo "LE_email:" $LE_email
echo "LE_domain:" $LE_domain

# Apache gets grumpy about PID files pre-existing
rm -f /run/apache2/apache2.pid

service php8.1-fpm start

if [[ $LE_on == 'true' ]]; then

	if [[ $LE_staging == 'true' ]]; then
       	echo "LE will use staging certificate"
    		STAGING='--test-cert'
	fi
	LE_CONF=/etc/apache2/sites-enabled/000-default-le-ssl.conf
	if [[ ! -f "$LE_CONF" ]]; then
    		/usr/sbin/apachectl start
        echo "LE need to create conf files. Issuing:"
        set -x
        certbot --non-interactive --apache --redirect --agree-tos --domains $LE_domain --email $LE_email $STAGING
        set +x
   		/usr/sbin/apachectl stop
		sleep 5
	fi
fi

cron
exec /usr/sbin/apachectl -DFOREGROUND
