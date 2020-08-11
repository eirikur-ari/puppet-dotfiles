# puppet-dotfiles

[![Build Status](https://travis-ci.com/eirikur-ari/puppet-dotfiles.svg?branch=master)](https://travis-ci.com/eirikur-ari/puppet-dotfiles)
[![Puppet Forge](https://img.shields.io/puppetforge/v/eirikur/dotfiles.svg)](https://forge.puppetlabs.com/eirikur/dotfiles)


## About
This module installs [my dotfiles](eirikur-ari/dotfiles) to a Linux machine (Puppet agent).

## Usage
To install the dotfiles package with default values:

```puppet
include dotfiles
```

Customized setup:

```puppet
class { 'dotfiles':
  github_ssh_key            => 'example_rsa_key',
  ssh_known_hosts_file_path => 'example/ssh_known_hosts',
  ssh_config_dir            => 'example/.ssh',
  dotfiles_install_path     => 'example/dotfiles',
  dotfiles_repository_url   => 'git@some.repo:example/dotfiles.git',
  dotfiles_install_script   => 'example.sh',
}
```

## Development 

### Requirements
Puppet version: 5.5\
Ruby version: 2.5.7

### Unit Testing

#### Create Gemset (Optional)
It is considered a good practice to keep the product Gem dependencies separated from the local Gems. One of the options is to create a new Gem collection (GemSet) using tool such as [RVM](https://rvm.io/). See the following command for an example:

```
rvm use 2.5.7@dotfiles --create
```

#### Install Gems
The following command will install all the product Gem dependencies listed in the Gemfile.

```bash
bundle install
```

#### Run Unit Tests
The following command will install the dependant Puppet Modules as well as create a symlink to the module under development, execute the unit tests and report on the test coverage.

In order to execute the tests, run the following command:

```bash
rake test
```

**Note:** After the tests have been executed the command will remove the Puppet Modules from *spec/fixtures/modules*

### Smoke Testing
The [Vagrant](https://www.vagrantup.com/) configuration provides a [multi-machine](https://www.vagrantup.com/docs/multi-machine) setup. By default a version of CentOS is started when **vagrant up** is executed, the configuration makes sure that no other machine is started along with the primary machine (CentOS). 

#### Install the Puppet Module dependencies
In case the dependent Puppet modules are not available in the directory *spec/fixtures/modules* we need to run the following:

```bash
rake spec_prep
```

#### Start a Vagrant box
In order to start any Vagrant box other than the primary (CentOS) it is required to add the name of the box configuration as an addition to the **vagrant up** command. See the following example:

```bash
vagrant up ubuntu
```

The current machine offering is the following:
* centos
* fedora
* archlinux
* ubuntu

#### Apply the Puppet Module
The following command will apply the Puppet Module and refresh the shell.

```bash
puppet apply --modulepath=/vagrant/spec/fixtures/modules /vagrant/tests/init.pp && exec $SHELL -l
```

**Note:** It is currently required to be the *root* user to apply the Puppet Module