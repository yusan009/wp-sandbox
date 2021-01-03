#!/bin/bash

# ---------- wordpress セットアップスタート ------------ #
wp core install --url='http://localhost:8000' --title='wp-sandbox' --admin_user='sandbox' --admin_password='sandbox' --admin_email='wp@example.com'

wp language core install ja --activate

wp option update timezone_string 'Asia/Tokyo'
wp option update date_format 'Y-m-d'
wp option update time_format 'H:i'

wp plugin delete hello.php
wp theme delete twentytwenty
wp theme delete twentyseventeen
wp theme delete twentyeighteen
wp theme delete twentynineteen

wp plugin install wp-multibyte-patch --activate
wp plugin uninstall akismet