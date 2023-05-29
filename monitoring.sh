#!/bin/bash
# Bash script

arch=$(uname -a)
cpup=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
cpuv=$(cat /proc/cpuinfo | grep processor | wc -l)
fram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
fdisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ut += $3} {ft += $2} END {pri>
cpul=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%", $2 = $4)}')
lboot=$(uptime -s | awk '{printf("%s %s", $1, substr($2, 1, length($2) - 3))}')
lvm=$(lsblk | grep lvm | wc -l | awk '{if ($1){printf("Yes"); exit;} else print "No"}')
tcp=$(netstat -an | grep 'ESTABLISHED' | wc -l) log=$(users | wc -w)
ip=$(hostname -I)
mac=$(cat /sys/class/net/enp0s3/address)
sudo=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)
wall " Arquitectura: $arch
                Physical CPU: $cpup
                Virtual CPU: $cpuv
                Memory Usage: $uram/${fram}MB ($pram%)
                Disk Usage: $udisk/${fdisk}GB ($pdisk%)
                CPU Load: $cpul
                Last Boot: $lboot
                LVM Use: $lvm
                TCP Connections: $tcp
                User Log: $log
                Network: IPv4 Address: $ip
                MAC Address: ($mac)
                Sudo: $sudo commands"