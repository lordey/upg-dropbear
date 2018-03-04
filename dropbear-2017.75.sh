#!/bin/bash
# upgrade dropbear-2017.75
cd
apt-get install -y gcc zlib1g-dev build-essential
wget https://matt.ucc.asn.au/dropbear/dropbear-2017.75.tar.bz2
tar xjvf dropbear-2017.75.tar.bz2
cd dropbear-2017.75
dpkg-buildpackage
apt-get purge --remove dropbear
apt-get remove --purge dropbear
apt-get autoremove
apt-get autoclean
rm -rf /etc/dropbear
cd .. 
ls
dpkg -i dropbear_2017.75-0.1_i386.deb
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# konfigurasi dropbear
cat > /etc/default/dropbear <<-END
# disabled because OpenSSH is installed
# change to NO_START=0 to enable Dropbear
NO_START=0

# the TCP port that Dropbear listens on
DROPBEAR_PORT=109

# any additional arguments for Dropbear
DROPBEAR_EXTRA_ARGS="-p 110 -p 22507 -p 53"

# specify an optional banner file containing a message to be
# sent to clients before they connect, such as "/etc/issue.net"
DROPBEAR_BANNER="/etc/issue.net"

# RSA hostkey file (default: /etc/dropbear/dropbear_rsa_host_key)
#DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"

# DSS hostkey file (default: /etc/dropbear/dropbear_dss_host_key)
#DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"
                              
# Receive window size - this is a tradeoff between memory and
# network performance
DROPBEAR_RECEIVE_WINDOW=65536







END

# restart dropbear
service ssh restart
service dropbear restart


