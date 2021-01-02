== Links ==
* [https://help.ubuntu.ru/wiki/access_control_list Access Control List - списки контроля доступа]


== Examples ==
<pre>
sudo setfacl -m u::rw,g::r,u:1950:r /var/log/pushservice.log
sudo setfacl -d -m u::rwx,g::rx,o::x,u:1950:r /var/log
getfacl /var/log
</pre>