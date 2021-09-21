#! /usr/bin/env bash

# The architecture of your operating system and its kernel version.
ARCHITECTURE=$(uname -snrvmo)

# The number of physical processors.
PCPU=$(lscpu | grep "Core(s) per socket:" | awk '{print $4}')

# The number of virtual processors.
VCPU=$(lscpu | grep "CPU(s):" | awk 'NR==1{print $2}')

# The current available RAM on your server and its utilization rate as a percentage.
USED_MEM=$(free -m | grep "Mem:" | awk '{print $3}')
TOTAL_MEM=$(free -m | grep "Mem:" | awk '{print $2}')
PERC_MEM=$(free -m | awk 'NR==2 {printf "%.2f%%", $3*100/$2}')

# The current available memory on your server and its utilization rate as a percentage.
USED_DISK=$(df -m --total | awk 'END{print $3}')
TOTAL_DISK=$(df -h --total | awk 'END{print $2}')
PERC_DISK=$(df -h --total | awk 'END{print $5}')

# The current utilization rate of your processors as a percentage.
CPU_USAGE=$(top -b -n 1 | grep "%Cpu(s):" | awk '{print $2"%"}')

# The date and time of the last reboot.
LAST_REBOOT=$(who -b | awk '{print $3, $4}')

# Whether LVM is active or not.
if [ $(lsblk | grep 'lvm' | wc -l) -eq 0 ]; then
	LVM_STATUS="no"
else
	LVM_STATUS="yes"
fi

# The number of active connections.
TOTAL_CONNECT=$(netstat -ant | grep ESTABLISHED | wc -l)

# The number of users using the server.
USER_LOGGED=$(who | wc -l)

# The IPv4 address of your server and its MAC (Media Access Control) address.
IP_ADDRESS=$(/usr/sbin/ifconfig enp0s3 | grep 'inet' | awk 'NR==1{print $2}')
MAC_ADDRESS=$(/usr/sbin/ifconfig enp0s3 | grep 'ether' | awk '{print $2}')

# The number of commands executed with the sudo program.
TOTAL_SUDO=$(cat /var/log/sudo/sudo.log | wc -l)

# For the script run stepping 10 minutes after last startup
TOTAL_SLEEP=$(last --time-format iso reboot \
				| grep "still running" \
				| awk  '{print $5}' \
				| cut -dT -f2 \
				| cut -d- -f1  \
				| cut -d: -f2,3 \
				| sed 's/:/ /' \
				| awk  '{printf ((($1%10)*60)+$2)}')

sleep ${TOTAL_SLEEP} && wall -n "\
	#Architecture: ${ARCHITECTURE}
	#CPU physical : ${PCPU}
	#vCPU : ${VCPU}
	#Memory Usage: ${USED_MEM}/${TOTAL_MEM}MB (${PERC_MEM})
	#Disk Usage: ${USED_DISK}/${TOTAL_DISK} (${PERC_DISK})
	#CPU load: ${CPU_USAGE}
	#Last boot: ${LAST_REBOOT}
	#LVM use: ${LVM_STATUS}
	#Connexions TCP : ${TOTAL_CONNECT} ESTABLISHED
	#User log: ${USER_LOGGED}
	#Network: IP ${IP_ADDRESS} (${MAC_ADDRESS})
	#Sudo : ${TOTAL_SUDO} cmd"
