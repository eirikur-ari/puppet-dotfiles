# dotfiles/modules/install.pp

class dotfiles::install(
  $epel_release_source = '',
) {

  case $::operatingsystem {
    'CentOS': {
      package { 'epel-release':
        ensure   => 'present',
        provider => 'rpm',
        source   => $epel_release_source
      }
      package { 'python-pip': ensure => 'installed', require => Package['epel-release'] }
    }
    default: {
      package { 'python-pip': ensure => 'installed'}
    }
  }

  package { 'pygments': ensure => 'present', provider => 'pip', require  => Package['python-pip'] }
  package { 'vim':  ensure => 'installed' }
  package { 'tree': ensure => 'installed' }
  package { 'git':  ensure => 'installed' }
  package { 'subversion':  ensure => 'installed' }

}