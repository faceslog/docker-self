## Nextcloud

Once Installed with docker you need to do the following to get it working properly:


### <span style="color: rgb(74 222 128);">Add to Nginx proxy manager:</span>

```nginx
location /.well-known/carddav {
	return 301 $scheme://$host/remote.php/dav;
}

location /.well-known/caldav {
	return 301 $scheme://$host/remote.php/dav;
}
```

### <span style="color: rgb(74 222 128);">Inside container's data edit config/config.php:</span>

- Before trusted_domains: `'overwriteprotocol' => 'https',`
- EOF: `'default__phone__region' => 'FR',`

### <span style="color: rgb(74 222 128);">Inside container's data edit root .htaccess:</span>

```htaccess
php_value memory_limit 2G
php_value upload_max_filesize 20G
php_value post_max_size 20G
php_value max_input_time 3600
php_value max_execution_time 3600
```

### <span style="color: rgb(74 222 128);">Attach the container and run from inside:</span>

 **<span style="color: rgb(45 212 191);">Inside container's data edit root .htaccess:</span>**  `docker exec -it <mycontainer> bash`

```sh
apt update
apt install libmagickcore-6.q16-6-extra
```

### <span style="color: rgb(74 222 128);">Add a cron on system machine & set to cron in basic settings:</span>
```sh
*/5 * * * * docker exec -u www-data nameofconteiner php cron.php
```

### <span style="color: rgb(74 222 128);">Maintenance Mode:</span>
```
docker exec -i -t --user www-data [containername] php /var/www/html/occ maintenance:mode --on
```