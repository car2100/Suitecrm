#!/bin/bash -xi

sleep 7
if [[ ! -f /install/config.php ]]; then
./bin/console suitecrm:app:install -u "$SUITECRM_ADMIN" -p "$SUITECRM_ADMIN_PASSWORD" -U "$SUITECRM_DB_USER" -P "$SUITECRM_DB_USER_PASSWORD" -H "$SUITECRM_DB_HOSTNAME" -N "$SUITECRM_DB_NAME" -S "$SUITECRM_URL" -d "$SUITECRM_DB_POPULATE" -W "true"
cp /var/www/html/public/legacy/config.php /install
cp /var/www/html/public/legacy/config_override.php /install
cp /var/www/html/public/legacy/config_si.php /install

else
cp -r /install/config.php /var/www/html/public/legacy
cp -r /install/config_override.php /var/www/html/public/legacy
cp -r /install/config_si.php /var/www/html/public/legacy
./bin/console suitecrm:app:install -u "$SUITECRM_ADMIN" -p "$SUITECRM_ADMIN_PASSWORD" -U "$SUITECRM_DB_USER" -P "$SUITECRM_DB_USER_PASSWORD" -H "$SUITECRM_DB_HOSTNAME" -N "$SUITECRM_DB_NAME" -S "$SUITECRM_URL" -d "$SUITECRM_DB_POPULATE" -W "true"
fi

echo DATABASE_URL="mysql://$SUITECRM_DB_USER:$SUITECRM_DB_USER_PASSWORD@$SUITECRM_DB_HOSTNAME/$SUITECRM_DB_NAME" > /var/www/html/.env.local
chown -R www-data:www-data /var/www/html/public/legacy
chmod -R 755 /var/www/html/public/legacy
sed -i "s|RewriteBase suitecrm.comlegacy/|RewriteBase /public/legacy|" /var/www/html/public/legacy/.htaccess
apachectl -D FOREGROUND
