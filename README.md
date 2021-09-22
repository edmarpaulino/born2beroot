<h1 align=center>
	<b>born2beroot</b>
</h1>

<h4 align=center>
	This document is a System Administration related exercise.	
</h4>

<p align=center>
	In this repo you will find all the documentation and codes developed during the <i>born2beroot</i> project, both <b>mandatory</b>'s Part and <b>bonus</b>.
</p>

---

<div align=center>
<h2>
	Final score
</h2>
<img src=https://github.com/edmarpaulino/42projects_pics/blob/master/score_edpaulin_libft.png alt=edpaulin's 42Project Score/>
<h4>Completed + Bonus</h4>
<img src=https://github.com/edmarpaulino/42projects_pics/blob/master/born2berootm.png alt=edpaulin's 42Project Badge/>
</div>

---


<div align=center>
<img src=https://github.com/edmarpaulino/born2beroot/blob/master/img/your-world.png alt=edpaulin's 42Project/>
</div>

<h3 align=center>
Part 1
</h3>

> <i>This project aims to introduce you to the wonderful world of virtualization, and this project consists of having you set up your first server by following specific rules.</i>

<p align=center>

</p>


<h3 align=center>
Bonus
</h3>

> <i>Set up a functional WordPress website with the following services: lighttpd, MariaDB, and PHP.</i>
<p align=center>

</p>

---

## The project

### Virtual Machine

[What is a virtual machine (VM)?](https://azure.microsoft.com/en-us/overview/what-is-a-virtual-machine/#overview)

### Operating System

[CentOS Linux](https://www.centos.org/about/)

[Comparing Centos Linux and CentOS Stream](https://www.centos.org/cl-vs-cs/)

[CentOS vs. Debian: Key Similarities and Differences](https://www.openlogic.com/blog/centos-vs-debian#:~:text=CentOS%20is%20a%20free%20downstream,including%20the%20Ubuntu%20Linux%20distribution)

[How To List Startup Services At Boot In Linux](https://ostechnix.com/how-to-list-startup-services-at-boot-in-linux)

### LVM

[LVM](https://wiki.ubuntu.com/Lvm)

### DNF

[DNF](https://fedoraproject.org/wiki/DNF)

### Static IP

[How to configure a static IP address on RHEL 8 / CentOS 8 Linux](https://linuxconfig.org/rhel-8-configure-static-ip-address)

Network configuration file:
```bash
sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
```
Change only lines `BOOTPROTO` `IPV6INIT` `ONBOOT` and add the follow lines at the end of the file:
```
IPADDR=192.168.0.110
GATEWAY=192.168.0.1
DNS1=192.168.0.1
DNS2=255.255.255.0
```
Your file should look like this::
```vi
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=enp0s3
UUID=620ec731-3c6c-42df-8a0f-c6f81f1d2325
DEVICE=enp0s3
ONBOOT=yes
IPADDR=192.168.0.110
GATEWAY=192.168.0.1
DNS1=192.168.0.1
DNS2=255.255.255.0
```
Restart the `NetworkManager`:
```bash
sudo systemctl restart NetworkManager
```

### SE Linux

[What is SELinux?](https://www.redhat.com/en/topics/linux/what-is-selinux)

[A Beginner's Guide to SELinux on CentOS 8](https://www.linode.com/docs/guides/a-beginners-guide-to-selinux-on-centos-8/)

[semanage command not found in CentOS 8 / RHEL 8](https://www.itzgeek.com/how-tos/linux/centos-how-tos/semanage-command-not-found-in-centos-8-rhel-8.html)

Check which package provide the `semanage`:
```bash
sudo yum whatprovides semanage
```
In my case the package is `policycoreutils-python-utils`:
```bash
sudo yum install policycoreutils-python-utils
```

### SSH

[Secure Shell (SSH)](https://searchsecurity.techtarget.com/definition/Secure-Shell)

[How to change the ssh port on Linux or Unix server](https://www.cyberciti.biz/faq/howto-change-ssh-port-on-linux-or-unix-server)

[Enable or disable remote root login](https://www.ibm.com/docs/en/db2/11.1?topic=installation-enable-disable-remote-root-login)

`SSH` configuration file:
```bash
sudo vi /etc/ssh/sshd_config
```
Change the lines that contains `Port` and `PermitRootLogin`:
```vi
Port 4242
PermitRootLogin no
```
Check `SELinux` `SSH` ports configuration:
```bash
sudo semanage port -l | grep ssh
```
Add the port `4242` in the `SELinux` `SSH` rule:
```bash
sudo semanage port -a -t ssh_port_t -p tcp 4242
```

### UFW

[What Is a Firewall?](https://www.cisco.com/c/en/us/products/security/firewalls/what-is-a-firewall.html)

[Install and Setup UFW Firewall on CentOS 8 / RHEL 8](https://shouts.dev/install-and-setup-ufw-firewall-on-centos-8-rhel-8)

[How to Configure a Firewall with UFW](https://www.linode.com/docs/guides/configure-firewall-with-ufw)

[How to Install and Enable EPEL Repository on CentOS 8/7/6](https://www.tecmint.com/install-epel-repository-on-centos/#:~:text=EPEL%20\(Extra%20Packages%20for%20Enterprise,%2C%20CentOS%2C%20and%20Scientific%20Linux.)

Install `EPEL` repository:
```bash
sudo yum install epel-release
```
Install `UFW`:
```bash
sudo yum install ufw
```
Start `UFW`:
```bash
sudo systemctl start ufw
```
```bash
sudo systemctl enable ufw
```
Check `UFW` status:
```bash
sudo ufw status
```
Add rule for port 4242:
```bash
sudo ufw allow 4242
```
Check `UFW` status with index in the rules:
```bash
sudo ufw status numbered
```
Delete a rule from its index:
```bash
sudo ufw delete <number>
```

### Hostname

[What is Hostname in Linux and How Can You Change It?](https://www.maketecheasier.com/hostname-in-linux/)

Show machine hostname: 
```bash
hostname
```
Change machine hostname:
```bash
sudo hostnamectl set-hostname <new-hostname>
```

### Password policy

[Pwquality : Set Password Rules](https://www.server-world.info/en/note?os=CentOS_8&p=pam&f=1)

[How to Change User Password in Linux](https://linuxize.com/post/how-to-change-user-password-in-linux/)

Password configuration file:
```bash
sudo vi /etc/login.defs
```
```vi
## These rules only apply to new users:
# Set number of days for password expiration.
PASS_MAX_DAYS	30
# Set minimum number of days available of password.
PASS_MIN_DAYS	2
# Set number of days for warnings before expiration.
PASS_WARN_AGE	7
```
Set number of days for password expiration for entered user:
```bash
sudo chage -M 30 <username>
```
Set minimum number of days available of password for entered user:
```bash
sudo chage -m 2 <username>
```
Set number of days for warnings before expiration for entered user:
```bash
sudo chage -W 7 <username>
```
Lists the password settings of the entered user:
```bash
sudo chage -l <username>
```
`Pwquality` configuration file:
```bash
sudo vi /etc/pam.d/system-auth
```
Append to a `password require` line:
```vi
retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 difok=7 reject_username enforce_for_root
```
- `retry` - number of attempts
- `minlen` - minimum length
- `ucredit` - minimum uppercase
- `dcredit` - minimum digits
- `maxrepeat` - maximum repeated characters
- `difok` - maximum characters contained in previous password
- `reject_username` - reject username in the password
- `enforce_for_root` - apply rules to `root` user

Set or change user password:
```bash
sudo passwd <username>
```

### SUDO

[Sudo in Linux](https://www.lifewire.com/what-is-sudo-2197466)

[How to enable sudo on Red Hat Enterprise Linux](https://developers.redhat.com/blog/2018/08/15/how-to-enable-sudo-on-rhel#)

[10 Useful Sudoers Configurations for Setting ‘sudo’ in Linux](https://www.tecmint.com/sudoers-configurations-for-setting-sudo-in-linux/)

Intall `SUDO`:
```bash
sudo yum install sudo
```
Configure `SUDO`:
```bash
sudo visudo
```
Add the follow lines to configure sudo group after create the sudo group:
```vi
## Allows people in group sudo to run all commands
%sudo   ALL=(ALL)       ALL
```

Add the follow lines at the end of the file:
```vi
`Defaults	passwd_tries=3`
`Defaults	badpass_message="I think something wrong is not right."`
`Defaults	logfile=/var/log/sudo/sudo.log`
`Defaults	requiretty`
`Defaults	secure_path=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`
```
- `passwd_tries` - increase SUDO password tries limit
- `badpass_message` - show custom message when you enter wrong SUDO password
- `logfile` - create a SUDO log file
- `requiretty` - enable SUDO on TTY user login session
- `secure_path` - set a secure PATH


### Groups and Users

[How to Create Users in Linux (useradd Command)](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/)

[How to List Groups in Linux](https://linuxize.com/post/how-to-list-groups-in-linux/)

[How to Add User to Group in Linux](https://linuxize.com/post/how-to-add-user-to-group-in-linux/)

[How to Delete Group in Linux (groupdel Command)](https://linuxize.com/post/how-to-delete-group-in-linux/)

List all users in alphabetical order:
```bash
sudo cat /etc/passwd | cut -d: -f1 | sort | less
```
Create a new user:
```bash
sudo useradd -m <new-username>
```
Delete a user:
```bash
sudo userdel -r <username>
```
List all groups in alphabetical order:
```bash
sudo getent group | cut -d: -f1 | sort | less
```
Lists all groups of the informed user:
```bash
sudo groups <username>
```
Creat a new group:
```bash
sudo groupadd <new-group-name>
```
Add a user to a group:
```bash
sudo usermod -aG <group> <user-name>
```
Remove a user from a group:
```bash
sudo gpasswd -d <username> <group-name>
```
Delete a group:
```bash
sudo groupdel <group-name>
```

### Monitoring script

[wall command in Linux with Examples](https://www.geeksforgeeks.org/wall-command-in-linux-with-examples/)

[Basic Linux Commands to Check Hardware and System Information](https://medium.com/technology-hits/basic-linux-commands-to-check-hardware-and-system-information-62a4436d40db)

[Linux 101: Check Disk Space Command](https://www.linux.com/training-tutorials/linux-101-check-disk-space-command/)

[Finding CPU usage from top command](https://askubuntu.com/questions/68741/finding-cpu-usage-from-top-command)

[How to Automate Regular Tasks with Cron on CentOS 8](https://serverspace.io/support/help/automate-regular-tasks-cron-centos-8/)

[crontab ifconfig outputting nothing](https://serverfault.com/questions/37244/crontab-ifconfig-outputting-nothing)

[netstat Command not found on CentOS 8 / RHEL 8 – Quick Fix](https://www.itzgeek.com/how-tos/linux/centos-how-tos/netstat-command-not-found-on-centos-8-rhel-8-quick-fix.html)

Start `cron`:
```bash
sudo systemctl start crond
```
```bash
sudo systemctl enable crond
```
Change current user `cron` settings:
```bash
sudo crontab -e
```
Change the `cron` settings of the informed user:
```bash
sudo crontab -u root -e
```
List current user `cron` settings:
```bash
sudo crontab -l
```
List the `cron` settings of the informed user:
```bash
sudo crontab -u root -l
```
The [monitoring.sh](monitoring.sh) script.

---

## Bonus

[How to Install Lighttpd with PHP and MariaDB on CentOS/RHEL 8/7](yberciti.biz/faq/howto-change-ssh-port-on-linux-or-unix-server/)

[ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)](https://stackoverflow.com/questions/21944936/error-1045-28000-access-denied-for-user-rootlocalhost-using-password-y)

[How to install WordPress on Lighttpd web server- Ubuntu 20.04/18.04](https://www.how2shout.com/linux/install-wordpress-on-lighttpd-web-server-ubuntu/)

### lighhtp

Install `lighttpd`:
```bash
sudo yum install lighttpd
```
Start `lighttpd`:
```bash
sudo systemctl start lighttpd
```
```bash
sudo systemctl enable lighttpd
```
Check `HTTP` rules in `SELinux`:
```bash
sudo semanage port -l | grep http
```
If necessary add the port `80` in the `SELinux` `HTTP` rule: 
```bash
sudo semanage port -a -t http_port_t -p tcp 80
```
Add the `HTTP` rule in `UFW`:
```bash
sudo ufw allow http
```

Check that `lighttpd` is working by accessing your IP address in your web browser.

### MariaDB

Install `MariaDB`:
```bash
sudo yum install mariadb mariadb-server
```

Start `MariaDB`:
```bash
sudo systemctl start mariadb
```
```bash
sudo systemctl enable mariadb
```

`MariaDB` security settings:
```bash
sudo mysql_secure_installation
```

Access the database:
```bash
sudo mariadb -u root -p
```

Create a database:
```
CREATE DATABASE <wordpress-database>;
```

Create new user to control this database:
```
CREATE USER 'wordpress-username'@'localhost' IDENTIFIED BY 'user-password'
```

Give privileges to control the database:
```
GRANT ALL PRIVILEGES ON <wordpress-database>.* TO 'wordpress-username'@'localhost';
FLUSH PRIVILEGES;
```

Other `MariaDB` commands

List all databases:
```
show databases
```
Change to database:
```
use <database-name>
```
Show database tables:
```
show tables
```
List database table columns:
```
select <column-name>,<other-column-name>,... FROM <table name>;
```

### PHP
Install `Remi` repository that provides a wide range of PHP versions for RedHat Enterprise Linux:
```bash
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
```
Confirm its modules:
```bash
sudo yum module list php
```
Enable its last version:
```bash
sudo yum module enable php:remi-8.0
```
Install `PHP` packages:
```bash
 sudo yum install php php-mysqlnd php-pdo php-gd php-mbstring php-fpm lighttpd-fastcgi
```
Configure `PHP-FPM`:
```bash
sudo vi /etc/php-fpm.d/www.conf
```
Change the `user`, `group` and `listen` like this:
```vi
; Unix user/group of processes
; Note: The user is mandatory. If the group is not set, the default user's group
;       will be used.
; RPM: apache user chosen to provide access to the same directories as httpd
user = lighttpd
; RPM: Keep a group allowed to write in log dir.
group = lighttpd

; The address on which to accept FastCGI requests.
; Valid syntaxes are:
;   'ip.add.re.ss:port'    - to listen on a TCP socket to a specific IPv4 address on
;                            a specific port;
;   '[ip:6:addr:ess]:port' - to listen on a TCP socket to a specific IPv6 address on
;                            a specific port;
;   'port'                 - to listen on a TCP socket to all addresses
;                            (IPv6 and IPv4-mapped) on a specific port;
;   '/path/to/unix/socket' - to listen on a unix socket.
; Note: This value is mandatory.
listen = 127.0.0.1:9000
```
Configure `PHP`:
```bash
sudo vi /etc/php.ini
```
Configure the `cgi.fix_pathinfo` to 1:
```vi
; cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI.  PHP's
; previous behaviour was to set PATH_TRANSLATED to SCRIPT_FILENAME, and to not grok
; what PATH_INFO is.  For more information on PATH_INFO, see the cgi specs.  Setting
; this to 1 will cause PHP CGI to fix its paths to conform to the spec.  A setting
; of zero causes PHP to behave as before.  Default is 1.  You should fix your scripts
; to use SCRIPT_FILENAME rather than PATH_TRANSLATED.
; http://php.net/cgi.fix-pathinfo
cgi.fix_pathinfo=1
```
Configure `lighttpd` modules:
```bash
sudo vi /etc/lighttpd/modules.conf
```
In this part:
```vi
##
## FastCGI (mod_fastcgi)
##
include "conf.d/fastcgi.conf"
```
Configure `lighttpd fast CGI`:
```bash
vi /etc/lighttpd/conf.d/fastcgi.conf
```
Like this:
```
##
## PHP Example
## For PHP don't forget to set cgi.fix_pathinfo = 1 in the php.ini.
##
## The number of php processes you will get can be easily calculated:
##
## num-procs = max-procs * ( 1 + PHP_FCGI_CHILDREN )
##
## for the php-num-procs example it means you will get 17*5 = 85 php
## processes. you always should need this high number for your very
## busy sites. And if you have a lot of RAM. :)
##
#fastcgi.server = ( ".php" =>
#                   ( "php-local" =>
#                     (
#                       "socket" => socket_dir + "/php-fastcgi-1.socket",
#                       "bin-path" => server_root + "/cgi-bin/php5",
#                       "max-procs" => 1,
#                       "broken-scriptfilename" => "enable",
#                     ),
#                     "php-tcp" =>
#                     (
#                       "host" => "127.0.0.1",
#                       "port" => 9999,
#                       "check-local" => "disable",
#                       "broken-scriptfilename" => "enable",
#                     ),
#                     "php-num-procs" =>
#                     (
#                       "socket" => socket_dir + "/php-fastcgi-2.socket",
#                       "bin-path" => server_root + "/cgi-bin/php5",
#                       "bin-environment" => (
#                         "PHP_FCGI_CHILDREN" => "16",
#                         "PHP_FCGI_MAX_REQUESTS" => "10000",
#                       ),
#                       "max-procs" => 5,
#                       "broken-scriptfilename" => "enable",
#                     ),
#                   ),
#                 )

fastcgi.server += ( ".php" =>
                    (
                      (
                        "host" => "127.0.0.1",
                        "port"=> "9000",
                        "broken-scriptfilename" => "enable"
                       )
                     )
                  )
```
Configure SELinux to allowing connection to your `HTTP` server and your database:
```bash
sudo setsebool -P httpd_can_network_connect 1
```
```bash
sudo setsebool -P httpd_can_network_connect_db 1
```
Start `PHP-FPM`
```bash
sudo systemctl start php-fpm
```
```bash
sudo systemctl enable php-fpm
```
Configure `lighttpd`:
```bash
sudo vi /etc/lighttpd/lighttpd.conf
```
In this part:
```vi
##
## Document root
##
server.document-root = server_root + "/html"
```
Create a `PHP` page to check if it's work:
```bash
vi /var/www/html/info.php
```
Add the following lines:
```php
<?php
phpinfo();
?>
```
After that check if this works by entering your web browser with your IP address and `info.php`, like this:
```
111.222.333.444/info.php
```

### WordPress
Install `wget` and `tar`:
```bash
sudo yum install wget tar
```
Download `WordPress`:
```bash
sudo wget http://wordpress.org/latest.tar.gz
```
Extract files:
```bash
sudo tar -xzvf latest.tar.gz
```
Move files to `/var/www/html/` directory:
```bash
sudo mv wordpress/* /var/www/html/
```
Remove downloaded file:
```bash
sudo rm -rf latest.tar.gz wordpress
```
Rename `WordPress` configuration file:
```bash
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
```
Configure `WordPress`:
```bash
sudo vim /var/www/html/wp-config.php
```
Change the following lines:
```vi
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'your-mariadb-username' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password-of-your-mariadb-user' );

/** MySQL hostname */
define( 'DB_HOST', '-hostname-of-your-machine' );
```
Change the user and group that owns the file:
```bash
sudo chown -R lighttpd:lighttpd /var/www/html/wordpress
```
```bash
sudo chmod -R 755 /var/www/html/wordpress
```
```bash
sudo chcon -R -t httpd_sys_rw_content_t /var/www/html/wordpress
```

### Fail2ban

#### This was a service of my choice.

[What is Fail2Ban?](https://www.smartdigitalsolutions.co.uk/what-is-fail2ban)

[How To Protect SSH With Fail2Ban on CentOS 8](https://www.cyberciti.biz/faq/how-to-protect-ssh-with-fail2ban-on-centos-8/)

Install `fail2ban`:
```bash
sudo yum install fail2ban
```
Start`fail2ban`:
```bash
sudo systemctl start fail2ban
```
Check `fail2ban` status:
```bash
sudo fail2ban-client status
```
Check `SSH` status in `fail2ban`:
```bash
sudo fail2ban-client status sshd
```
Unban a IP:
```bash
sudo fail2ban-client set sshd unbanip < ip 111.222.333.444 >
```
Ban a IP:
```bash
sudo fail2ban-client set sshd banip <111.222.333.444>
```
