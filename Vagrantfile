# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
                          rsync__exclude: [".git/", "spec/fixtures/modules/dotfiles/spec"]


  config.vm.define "centos", primary: true do |centos|
    centos.vm.box = "centos/7"
    centos.vm.network "private_network", ip: "192.168.34.3"
    centos.vm.provision "shell", inline: <<-SHELL
      yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
      yum -y install puppet-agent
      yum -y install unzip
    SHELL
  end

  config.vm.define "fedora", autostart: false do |fedora|
    fedora.vm.box = "generic/fedora29"
    fedora.vm.network "private_network", ip: "192.168.35.3"
    fedora.vm.provision "shell", inline: <<-SHELL
      yum -y install https://yum.puppetlabs.com/puppet-release-fedora-30.noarch.rpm 
      yum -y install puppet-agent
      yum -y install unzip
    SHELL
  end

  config.vm.define "archlinux", autostart: false do |archlinux|
    archlinux.vm.network "private_network", ip: "192.168.36.3"
    archlinux.vm.box = "archlinux/archlinux"
    archlinux.vm.provision "shell", inline: <<-SHELL
      pacman -S puppet --noconfirm
      pacman -S unzip --noconfirm
    SHELL
  end
  
  config.vm.define "ubuntu", autostart: false do |ubuntu|
    ubuntu.vm.network "private_network", ip: "192.168.37.3"
    ubuntu.vm.box = "generic/ubuntu1904"
    ubuntu.vm.provision "shell", inline: <<-SHELL
      apt update -y
      apt install puppet -y
      apt install unzip -y
    SHELL
  end

  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /root/.ssh
    cp /vagrant/github_rsa /root/.ssh
   SHELL
end
