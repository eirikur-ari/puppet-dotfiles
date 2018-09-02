# my_workstation_setup/modules/install.pp

class my_workstation_setup::install(
  $epel_release_source,
) {
  package { 'epel-release':
    ensure   => 'present',
    provider => 'rpm',
    source   => $epel_release_source
  }

  package { 'vim':  ensure => 'installed' }
  package { 'tree': ensure => 'installed' }
  package { 'git':  ensure => 'installed' }
  package { 'subversion':  ensure => 'installed' }
  package { 'python-pip': ensure => 'installed', require => Package['epel-release'] }
  package { 'pygments': ensure => 'present', provider => 'pip', require  => Package['python-pip']}
}