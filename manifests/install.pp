# my_workstation_setup/manifests/install.pp

class my_workstation_setup::install {
  package { 'epel-release':
    ensure   => 'present',
    provider => 'rpm',
    source   => 'http://fedora.skyggnir.is/epel/epel-release-latest-7.noarch.rpm'
  }

  package { 'vim':  ensure => 'installed' }
  package { 'tree': ensure => 'installed' }
  package { 'git':  ensure => 'installed' }
  package { 'subversion':  ensure => 'installed' }
  package { 'python-pip': ensure => 'installed', require => Package['epel-release'] }
  package { 'pygments': ensure => 'present', provider => 'pip', require  => Package['python-pip']}
}