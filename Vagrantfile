# -*- mode: ruby -*-
# vi: set ft=ruby :

ip_address = "172.22.22.22"
project_name = "my-project"
one_for_all_password = "123456"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Enable Berkshelf support
  config.berkshelf.enabled = true

  # Use the omnibus installer for the latest Chef installation
  config.omnibus.chef_version = :latest

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./www-public" , "/var/www/" + project_name + "/",  :nfs => true, :mount_options => ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=2']
  config.vm.synced_folder "./dev-tools-public" , "/var/www/dev-tools-public/",  :nfs => true, :mount_options => ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=2']

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = true
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider :virtualbox do |v|
      v.gui = false
      v.customize ["modifyvm", :id, "--cpuexecutioncap", "95"]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", "2048"]
      v.customize ["modifyvm", :id, "--cpus", 4]
  end

  config.vm.provision :shell, :inline => "sed -i 's#archive.ubuntu.com#mirrors.163.com#' /etc/apt/sources.list"
  config.vm.provision :shell, :inline => "sed -i 's#security.ubuntu.com#mirrors.163.com#' /etc/apt/sources.list"
  config.vm.provision :shell, :inline => "apt-get update"
  # Use hostonly network with a static IP Address and enable
  # hostmanager so we can have a custom domain for the server
  # by modifying the host machines hosts file
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  
  config.vm.define project_name do |node|
    node.vm.hostname = project_name + ".local"
    node.vm.network :private_network, ip: ip_address
    node.hostmanager.aliases = [ "www." + project_name + ".local","dev-tools." + project_name + ".local", ]
  end
  config.vm.provision :hostmanager


  config.vm.provision "chef_solo" do |chef|
    #chef.log_level = :debug  
    
    chef.custom_config_path = "Vagrantfile.chef"

    chef.add_recipe "apt"
    chef.add_recipe "composer"
    chef.add_recipe "git"
    chef.add_recipe "nginx"
    chef.add_recipe "php5_ppa::from_ondrej"
    chef.add_recipe "php-fpm"

    chef.add_recipe "redisio"
    chef.add_recipe "php-redis"

    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"
    chef.add_recipe "app::install_other_package"
    chef.add_recipe "app::virtual_host"
    chef.add_recipe "app::link_phpredis"
    chef.json = {
      :app => {
        :name           => project_name
      },
      :php => {
        :ext_conf_dir => '/etc/php5/mods-available',
        :directives => {
          "date.timezone" => "Asia/Shanghai",
          "short_open_tag" => "Off",
          "display_errors" => "On"
        }
      },  
      :mysql =>{
        :server_root_password   => one_for_all_password,
        :server_repl_password   => one_for_all_password,
        :server_debian_password => one_for_all_password,
        :bind_address           => ip_address,
        :allow_remote_root      => true
      },
      :versions => {
        "php5" => '5.5.*'
      },
      :packages => [
        "php5-intl php5-mysqlnd php5-curl php5-mcrypt php5-gd php5-mcrypt"
      ]
    }

  end

end
