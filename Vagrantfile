# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Modify these variables to configure how MySQL data is imported
  # MySQL root credentials
    mysql_username = "root"
    mysql_password = "vagrantpassword"
  # MySQL test user credentials
    mysql_test_username = "testuser"
  # MySQL data to import
    mysql_database = "example_database"
    mysql_dumpfile = "/vagrant/vagrant-config/mysql/example-data.sql" # document root is /vagrant

  # Provision VM using a combination of bash scripts and Puppet

  config.vm.provision :shell, :path => "vagrant-config/bootstrap-puppet"

  config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "vagrant-config/manifests"
      puppet.manifest_file  = "default.pp"
      puppet.facter = {
        "mysql_database_name" => mysql_database,
        "mysql_root_password" => mysql_password,
        "mysql_test_username" => mysql_test_username,
      }
  end

  config.vm.provision(
    :shell,
    :path => "vagrant-config/setup-mysql",
    :args => "#{mysql_username} #{mysql_password} #{mysql_database} #{mysql_dumpfile}"
  )


  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/centos-6.5"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  config.vm.network "forwarded_port", guest: 80, host: 3000


  ##
  # Other potentially useful settings, taken from the default Vagrantfile
  #

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

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
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

end
