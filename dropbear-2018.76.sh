#!/bin/bash
# upgrade dropbear-2018.76
cd
apt-get install -y gcc zlib1g-dev build-essential
wget https://matt.ucc.asn.au/dropbear/dropbear-2018.76.tar.bz2
tar xjvf dropbear-2018.76.tar.bz2
cd dropbear-2018.76
dpkg-buildpackage
apt-get purge --remove dropbear
apt-get remove --purge dropbear
apt-get autoremove
apt-get autoclean
rm -rf /etc/dropbear
cd .. 
ls
dpkg -i dropbear_2018.76-0.1_i386.deb

# rebuild konfigurasi dropbear
wget https://raw.githubusercontent.com/lordey/konfigurasi-dropbear/master/dropbear-conf.sh && chmod +x dropbear-conf.sh && ./dropbear-conf.sh

# end