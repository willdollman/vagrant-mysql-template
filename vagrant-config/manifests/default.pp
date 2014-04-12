# Define MySQL configuration - users, databases, grants
$users = {
    'testuser@localhost' => {
        ensure        => 'present',
        password_hash => '*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29', # = test
    },
}
$database_name = 'example_database' # specify database name here
$databases = {
    "$database_name" => {           # double quotes required to interpolate variable
        ensure  => 'present',
        charset => 'utf8',
    },
}
$grants = {
    "testuser@localhost/$database_name.*" => {
        ensure => 'present',
        privileges => ['ALL'],
        table => "$database_name.*",
        user => 'testuser@localhost',
    },
}
# Perform MySQL configuration
class { '::mysql::server':
    root_password => 'vagrantpassword',
    users     => $users,
    databases => $databases,
    grants    => $grants,
}

# Basic Apache configuration
package { "httpd":
    ensure => present,
}
service { "httpd":
    ensure => running,
    require => Package["httpd"],
}
file { "/var/www/html/index.html":
    ensure => "link",
    target => "/vagrant/vagrant-config/html-example/index.html",
    require => Package["httpd"],
    notify => Service ["httpd"],
}

# Install some useful packages
package { "vim-enhanced":
    ensure => present,
}
package { "git":
    ensure => present,
}
