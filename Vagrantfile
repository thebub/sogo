# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 20000, host: 20000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 13306, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  config.vm.synced_folder "../sogo", "/home/vagrant/workspace/sogo", id: "sogo"
  config.vm.synced_folder "../sope", "/home/vagrant/workspace/sope", id: "sope"

  config.vm.provider "virtualbox" do |vb|
      vb.name = "vagrant-sogo"
  #   vb.gui = true
      vb.memory = "2048"
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    echo fs.inotify.max_user_watches=524288 >> /etc/sysctl.conf
    sysctl -p

    sysctl -w kernel.yama.ptrace_scope=0
    sysctl -p

    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -yq build-essential git gdb net-tools
    apt-get install -yq gnustep-make gnustep-base-runtime libgnustep-base-dev gobjc \
        libxml2-dev libssl-dev libldap2-dev libpq-dev libmysqlclient-dev \
        libmemcached-dev libcurl4-openssl-dev libsodium-dev libzip-dev
    apt-get install -yq nodejs npm node-grunt-cli
    #npm install -g @angular/cli
    apt-get install -yq mariadb-server mariadb-client postfix dovecot-imapd nginx
    
    cp /home/vagrant/workspace/sogo/dev/sogo/sogo-dev.service /etc/systemd/system/

    install -m 750 -o vagrant -g vagrant -d /var/lib/sogo
    install -m 750 -o vagrant -g vagrant -d /var/log/sogo
    install -m 750 -o vagrant -g vagrant -d /var/spool/sogo
    install -m 750 -o vagrant -g vagrant -d /run/sogo
    install -m 750 -o vagrant -g vagrant -d /etc/sogo

    cp /home/vagrant/workspace/sogo/dev/sogo/sogo-dev.conf /etc/sogo/sogo.conf
    
    chmod 640 /etc/sogo/sogo.conf
    chown root:vagrant /etc/sogo/sogo.conf
    
    mariadb -u root -e "CREATE DATABASE IF NOT EXISTS sogo;"
    mariadb -u root -e "CREATE USER IF NOT EXISTS 'sogo'@localhost IDENTIFIED BY 'sogo';"
    mariadb -u root -e "CREATE USER IF NOT EXISTS 'sogo'@'%' IDENTIFIED BY 'sogo';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON sogo.* TO 'sogo'@localhost IDENTIFIED BY 'sogo';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON sogo.* TO 'sogo'@'%' IDENTIFIED BY 'sogo';"
    mariadb -u root -e "FLUSH PRIVILEGES;"

    mkdir -p /home/vagrant/node_modules && chown vagrant:vagrant /home/vagrant/node_modules && ln -s /home/vagrant/node_modules /home/vagrant/workspace/sogo/UI/WebServerResources/node_modules

    mkdir -p /home/vagrant/workspace/.vscode && chown vagrant:vagrant /home/vagrant/workspace/.vscode && ln -s /home/vagrant/workspace/sogo/dev/vscode/launch.json /home/vagrant/workspace/.vscode/launch.json
    cp /home/vagrant/workspace/sogo/dev/mariadb/50-server.cnf /etc/mysql/maraidb.conf.d/50-server.cnf && chown root:vagrant /etc/mysql/maraidb.conf.d/50-server.cnf
    systemctl restart maraidb.service

    ln -s /home/vagrant/workspace/sogo/dev/nginx/dev.conf /etc/nginx/sites-enabled/sogo-dev.conf
    systemctl restart nginx.service
  SHELL
end
