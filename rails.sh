#!/bin/bash
#=======================================================================
# Arquivo: rails.sh
# This is more of a set of tips than a tested script, but I used Ubuntu Server 14.04
#=======================================================================

#=======================================================================
# 0. Declaracao de variaveis
#=======================================================================
LOG_FILE=/var/log/rails_bootstrap.log

#=======================================================================
# 1. Configuração Inicial
#=======================================================================
sudo su -
# configuração do endereço IP
sed -i "s/dhcp/static/g" /etc/network/interfaces
echo "	address 192.168.126.250" >> /etc/network/interfaces
echo "	netmask 255.255.255.0" >> /etc/network/interfaces
echo "	gateway 192.168.126.2" >> /etc/network/interfaces
# configuração do dns
echo "nameserver 192.168.126.2" >> /etc/resolvconf/resolv.conf.d/base
ifup eth0
ifdown eth0

# configuração do arquivo hostname
sed -i "s/ubuntu/rails/g" /etc/hostname
hostname rails
# configuração do arquivo hosts 
sed -i "s/ubuntu/rails/g" /etc/hosts
echo "1. Fim do Update do Linux: $?" >> $LOG_FILE

#=======================================================================
# 2. Update do Linux
#=======================================================================
apt-get -y update
echo "2. Fim do Update do Linux: $?" >> $LOG_FILE

#=======================================================================
# 3. Pacotes necessários para o Rails
#=======================================================================
apt-get -y install curl
apt-get -y install nodejs
apt-get -y install openssh-server
echo "3. Fim da instalacao dos Pacotes necessarios para o Ruby on Rails: $?" >> $LOG_FILE
 
#=======================================================================
# 4. Instalação do Ruby
#=======================================================================
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
echo "4. Fim da instalacao do Ruby via RVM: $?" >> $LOG_FILE

#=======================================================================
# 5. Instalação do Rails
#=======================================================================
gem install rails
echo "5. Fim da instalacao do Rails: $?" >> $LOG_FILE
 
#=======================================================================
# Fim
#=======================================================================
echo "Fim do Script...: $?" >> $LOG_FILE
