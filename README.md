[![Try in PWD](https://cdn.rawgit.com/play-with-docker/stacks/cff22438/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/jancelin/docker-lizmap/master/docker-compose.yml)

# docker-lizmap

LizMap is a complete Internet QGIS map publishing.
___________________________________________________________________________

## Building image:

docker build --build-arg lizmap_version=3.6.7 -t=opengisch/lizmap:3.6.7 .

## Using image:

With Docker-compose:

* Create a docker-compose.yml and changing the directory path if necessary (home/lizmap/lizmap_project):

https://github.com/opengisch/docker-lizmap/blob/master/docker-compose.yml

* UP

```
docker-compose up -d
```

* Now config lizmap on web :

```
http://localhost/admin.php/config
```
* change URL WMS:

>> http://qgiserver/cgi-bin/qgis_mapserv.fcgi

* Add **/io/qgis/** for looking your geo projects

![config](https://cloud.githubusercontent.com/assets/6421175/11306233/e945f342-8fb0-11e5-9906-4010b9398ef1.png)

* http://docs.3liz.com/fr/

## Upgrading from Lizmap 3.4 or 3.3

This image offers a way of migrating all your configuration and Userdatabase so that it can be
used with the new version.

For that just run:

```shell
docker run --rm -v <path-to-old-config>:/var/www/lizmap/previous-config -v <path-to-new-config>:/var/www/lizmap/var/config migrate.sh
```


If you want to reuse a database containing tables of Lizmap 3.3 or 3.4, create a directory somewhere,
for example `./lizmap-old-config`, and copy these files into it:

- at least the `installer.ini.php` of the Lizmap 3.3/3.4 installation (stored originally into `lizmap/var/config`)
- the `lizmapConfig.ini.php` file if you want to retrieve the list of projects
- the `profiles.ini.php` file if there are specific connection profiles
- the `localconfig.ini.php` and `liveconfig.ini.php` if you want to retrieve some specific configuration, but
  you should remove from them any reference to modules that are not used anymore into your new lizmap container.
- if you are using a sqlite database, the `jauth.db` database file (stored originally into `lizmap/var/db`)

The updated configuration is written to <path-to-new-config>. To test it you can mount it where your instance is running.

-------------------------------

Lizmap Web Application generates dynamically a web map application (php/html/css/js) with the help of Qgis Server ( QGIS Server Tutorial ). You can configure one web map per Qgis project with the QGIS LizMap Plugin.

http://docs.3liz.com/

http://www.3liz.com/

____________________________________________________________________________________

Julien ANCELIN ( julien.ancelin@inra.fr) 2017

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a>
