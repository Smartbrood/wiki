---
title: "Linux"
category: "main"
---

== TCP backlog ==
* [http://veithen.io/2014/01/01/how-tcp-backlog-works-in-linux.html How TCP backlog works in Linux]


== Filesystem ==
<pre>
lsblk --fs
sudo blkid -p /dev/nvme0n1

sudo e2label /dev/xvde external
</pre>


== Audit file access ==
<pre>
sudo apt install auditd
sudo /sbin/auditctl -w /run/nginx.pid -p war -k nginx-pid
sudo /sbin/ausearch -f /run/nginx.pid | more
</pre>


== Misc / Examples ==
<pre>
ps --ppid 2 -p 2 --deselect -o comm  - не показывать kernel threads 
ps aufx     - увидеть lxc
ls /etc/cron.*/* | xargs dpkg -S | grep 'no path  - найти файлы которых нет в пакетах


lscpu - архитектура cpu

getfacl /tmp - посмотреть acl

hostnamectl set-hostname ${hostname}

timedatectl set-timezone Europe/Moscow

pgrep docker|xargs -I GGG grep VmSwap /proc/GGG/status   - использование swap процессом docker   (grep VmSwap /proc/[PID]/status)
</pre>


== Reboot ==
<pre>
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
</pre>


== Logger ==
<pre>
logger 'Hello world'
tail /var/log/syslog
Nov  2 14:42:16 ip-10-0-101-59 ubuntu: Hello world
</pre>


== Random password ==
* pwgen

<pre>
dd if=/dev/urandom count=1 bs=512 | md5sum
</pre>




== Named pipes ==
<pre>
mkfifo ./pipe
echo "test" > ./pipe (blocking while read)
cat ./pipe (from other terminal)
</pre>


== sudo ==
<pre>
myusername ALL=(ALL) NOPASSWD:ALL
</pre>


== Сбор и анализ логов ==
* [https://habrahabr.ru/company/badoo/blog/280606/ Сбор и анализ логов демонов в Badoo]
** ELK состоит из трех компонентов:
*** Elastic Search. Система хранения и поиска данных, основанная на «движке» Lucene;
*** Logstash. «Труба» с кучей фич, через которую данные (возможно, обработанные) попадают в Elastic Search;
*** Kibana. Веб-интерфейс для поиска и визуализации данных из Elastic Search.
* мы взяли systemd + journald + https://papertrailapp.com/ (Олег Царев)


=== Logging from Docker ===
* container -> stdout, stderr -> docker logging driver = journald -> journald on localhost -> systemd-journal-remote or rsyslog to central syslog server


=== Проблема 1 (syslog + docker) ===
Стандартный способ общения между syslog-демоном и программой является unix socket /dev/log. Как говорилось выше, мы его пробросили внутрь контейнера стандартными средствами docker. Эта связка отлично работала до тех пор, пока нам не понадобилось перегрузить syslog-демон. Судя по всему, если перебрасывается конкретный файл, а не директория, то при удалении или пересоздании файла на хост-системе он уже не будет доступен внутри контейнера. Получается, что любая перезагрузка syslog-демона ведет к прекращению заливки логов из docker-контейнеров. Если пробрасывать директорию целиком, то внутри без проблем может быть unix-сокет, и перезагрузка демона не нарушит ничего. Но тогда усложняется настройка всего этого богатства, ведь libc ожидает, что сокет находится в /dev/log.

В конце концов мы решили запустить по одному syslog-демону в каждом контейнере и продолжать писать в /dev/log стандартными libc функциями openlog()/syslog().

Это не было большой проблемой, т.к. наши системные администраторы все равно в каждом контейнере используют init-систему, а не запускают только один демон.

А демоны, как я говорил выше, пишут в /dev/log синхронно и без какого-либо таймаута.
Результат предсказуем: из-за одного флудящего тестового демона тормозить начали все демоны, которые пишут в syslog хоть с какой-то значимой частотой.

...

Перед нами было несколько вариантов:
* уходить от syslog. Возвращаться к одному из других вариантов, которые предполагают, что демон пишет на диск, а уже какой-то другой демон абсолютно независимо читает с диска;
* продолжать писать в syslog синхронно, но в отдельном треде;
* написать свой syslog-клиент и посылать данные в syslog по UDP.

Самым правильным вариантом, пожалуй, является первый. Но мы не хотели тратить время на него и быстро сделали третий, т.е. начали писать в syslog по UDP. 



=== Проблема 2 (блокирующий syslog) ===



== Grep ==
<pre>
cat file | tr -d '\000' | yourgrep
</pre>


== CentOS ==
* [http://vault.centos.org/ vault.centos.org]
* systemd-machined - для управления виртуальными машинами и контейнерами
* hostnamectl 
* systemd-cgls
* systemd-cgtop
* [https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Resource_Management_Guide/index.html Resource_Management_Guide]
* [https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Resource_Management_Guide/sec-Setting_Cgroup_Parameters.html Setting_Cgroup_Parameters]


== Add HDD and Resize FS ==
Rescan disks:
<pre>
ls /sys/class/scsi_host
echo "- - -" > /sys/class/scsi_host/host0/scan
echo "- - -" > /sys/class/scsi_host/host1/scan
echo "- - -" > /sys/class/scsi_host/host2/scan
fdisk -l
</pre>

<pre>
pvcreate /dev/sde
vgextend vg4 /dev/sde
lvextend -l +100%FREE /dev/mapper/vg4-lv_bulkstat 
resize2fs /dev/mapper/vg4-lv_bulkstat 159G
</pre>


== LVM ==
* [http://help.ubuntu.ru/wiki/lvm Linux Volume Manager (LVM)]
* [http://docs.ansible.com/ansible/lvg_module.html ansible lvg_module]
* [http://docs.ansible.com/ansible/lvol_module.html ansible lvol_module]


<pre>
fdisk -l
pvcreate /dev/sdb
vgscan
vgextend vg_t /dev/sdb
lvcreate -l 100%FREE -n lv_csvdrop vg_t
mkfs.ext4 /dev/vg_t/lv_csvdrop

nano /ets/fstab -> /dev/mapper/vg_t-lv_csvdrop /opt/CSCOppm-unit/csvdrop                       ext4    defaults        1 1

cd /opt/CSCOppm-unit
mv ./csvdrop ./csvdrop-old
mkdir ./csvdrop
mount ./csvdrop
chown -R bin:ftpuser ./csvdrop
chmod g+w ./csvdrop
mv ./csvdrop-old/* ./csvdrop/
</pre>


<pre>
vgscan
vgchange -a y
mount /dev/volumegroup/logicalvolume /mnt/somewhere
</pre>