# puppet-dotfiles

[![Build Status](https://travis-ci.com/eirikur-ari/puppet-dotfiles.svg?branch=master)](https://travis-ci.com/eirikur-ari/puppet-dotfiles)
[![Puppet Forge](https://img.shields.io/puppetforge/v/eirikur/dotfiles.svg)](https://forge.puppetlabs.com/eirikur/dotfiles)


## Description
This module installs the latest version of [my dotfiles](eirikur-ari/dotfiles) to a Linux machine (Puppet agent). By default the repository will be cloned via HTTPS into the directory */usr/local/share/dotfiles*. 

## Usage
**To install the dotfiles package with default values:**

```puppet
include dotfiles
```

**Install via ssh key:**

```puppet
class { 'dotfiles':
  dotfiles_repository_url => 'git@github.com:eirikur-ari/dotfiles.git',
  use_ssh_key             => true,
}
```


**Example using all available custom options:**

```puppet
class { 'dotfiles':
  github_ssh_key            => 'example_rsa_key',
  ssh_known_hosts_file_path => 'example/ssh_known_hosts',
  ssh_config_dir            => 'example/.ssh',
  dotfiles_install_path     => 'example/dotfiles',
  dotfiles_repository_url   => 'git@some.repo:example/dotfiles.git',
  dotfiles_install_script   => 'example.sh',
  use_ssh_key               => true
}
```

## Development 

### Requirements
Puppet version: 4.10 or later\
Ruby version: 2.5.7

### Install dependencies

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

#### Alternative option
There is a second option and that is using the [make](http://www.gnu.org/software/make/) tool. Execute the following to create a new Gem collection and install the Gem dependencies:

```bash
make prep
```

### Unit Testing

#### Run Unit Tests
The following command will install the dependant Puppet Modules as well as create a symlink to the module under development, execute the unit tests and report on the test coverage.

In order to execute the tests, run the following command:

```bash
rake test
```
By default the repository will be cloned via HTTPS into the directory */usr/local/share/dotfiles*. 
**Note:** After the tests have been executed the command will remove the Puppet Modules from *spec/fixtures/modules*

#### Alternative option
As an alternative that will install the dependencies and execute the unit tests by using the [make](http://www.gnu.org/software/make/) tool. Execute the following:

```bash
make test
```

### Acceptance Testing
The project provides [Beaker](https://github.com/voxpupuli/beaker) setup to run acceptance tests via [Docker](https://www.docker.com/). Tests are automatically executed by [Travis CI](https://travis-ci.com/) for the following OS:

* Ubuntu
* CentOs
* Fedora

### Run manually
The following command will execute acceptance test using the default beaker configuration:

```bash
make acceptance
```

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

#### Alternative option
There is a alternative option available that will prepare the required Puppet Module setup and launch the default vagrant box using the [make](http://www.gnu.org/software/make/) tool. See the following:

```bash
make smoke
```

#### Apply the Puppet Module
The following command will apply the Puppet Module and refresh the shell.

```bash
puppet apply --modulepath=/vagrant/spec/fixtures/modules /vagrant/tests/init.pp && exec $SHELL -l
```

**Note:** If installed using default configuration, it is required to be use the *root* user to apply the Puppet Module