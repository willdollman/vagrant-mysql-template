# Vagrant MySQL Template

A template to help you quickly create a MySQL/Apache test environment (with all your MySQL databases), using Vagrant.

This template includes a few scripts and a Puppet manifest to get you started. 
Also, if you're trying to configure MySQL with Puppet, `manifests/default.pp` serves as an example to the [puppetlabs/mysql module](https://forge.puppetlabs.com/puppetlabs/mysql) documentation which really needs one.

The result is a CentOS 6.5 VM with MySQL and Apache installed, and your database dump loaded.

## Install

This assumes you've read the [getting started][vagrant-gettingstarted] guide for Vagrant. If you haven't you can probably wing it by skimming the first page and installing [Vagrant][vagrant] and [VirtualBox][virtualbox].

[vagrant-gettingstarted]: http://docs.vagrantup.com/v2/getting-started/
[vagrant]: http://www.vagrantup.com
[virtualbox]: https://www.virtualbox.org

Clone this repo with `git clone https://github.com/willdollman/vagrant-mysql-template.git`

Run `vagrant up` in that directory

Once Vagrant has built and provisioned the machine, you can access the web server at [http://127.0.0.1:3000](http://127.0.0.1:3000)

You can access the MySQL database by connecting to the VM with `vagrant ssh`, and then running `mysql -u testuser -ptest` (or `sudo mysql`) for root access.

To include this in your own project, run `cp -r Vagrantfile vagrant-config your-project-dir/`. You can then run `vagrant up` from within your project.

## Make it your own

- Set `mysql_dumpfile` to your own data file in `Vagrantfile`
- Copy your web app to `/var/www/html`
- Install your own packages using puppet

## How it works

Vagrant creates a CentOS 6.5 virtual machine. This is then provisioned with several scripts:

- `bootstrap-puppet` - the box used doesn't have Puppet installed, and we need it. This script adds the PuppetLabs repo, then installs the Puppet package. It also installs the puppetlabs/mysql module
- `manifests/default.pp` - this Puppet manifest installs and configures MySQL and Apache
	- Install the MySQL package
	- Create the `example_database` database
	- Adds the `testuser` user
	- Grants `testuser` full access to `example_database`
	- Installs Apache and sets up an example web page
	- Installs some other handy packages (vim, git)
- `setup-mysql` - imports an SQL dump into the database (eg, your test data)
