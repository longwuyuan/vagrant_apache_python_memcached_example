#!/bin/bash

echo "Deleting existing apache vhost configs"
rm -f /etc/apache2/sites-available/000-default.conf > /dev/null
rm -f /etc/apache2/sites-available/default-ssl.conf > /dev/null
rm -f /var/www/app/app.py > /dev/null
rm -f /var/www/app/app.wsgi > /dev/null
rm -f /var/www/app/templates/app.html.j2 > /dev/null
echo "Copying our custom apache vhost configs"
cp /tmp/000-default.conf /etc/apache2/sites-available/000-default.conf > /dev/null
cp /tmp/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf > /dev/null
cp /tmp/app.py /var/www/app/app.py > /dev/null
cp /tmp/app.wsgi /var/www/app/app.wsgi > /dev/null
cp /tmp/app.html.j2 /var/www/app/templates/app.html.j2 > /dev/null
echo "Enabling http site"
a2ensite 000-default.conf > /dev/null
echo "Enabling ssl site"
a2ensite default-ssl.conf > /dev/null
echo "Enabling module ssl"
a2enmod ssl > /dev/null
echo "Enabling module rewrite"
a2enmod rewrite > /dev/null
echo "Adding cronjob for memcached stats"
echo "* * * * * /home/vagrant/exercise-memcached.sh" > /home/vagrant/cronjob_memcached
crontab /home/vagrant/cronjob_memcached
echo "Updating apt repos"
apt-get --assume-yes update
echo "Installing memcached"
apt-get --assume-yes install memcached
pip install python-memcached-stats
echo "Restarting apache2 service"
service apache2 restart  1>&2 > /dev/null  # I lied
echo "Done customizing apache2"
