# dotfiles/modules/package.pp

class dotfiles::package(
  $epel_release_source = undef,
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

  package { 'pip': ensure   => 'latest', provider => 'pip', require  => Package['python-pip'] }
  package { 'pygments': ensure => 'present', provider => 'pip', require  => Package['pip'] }
  package { 'vim':  ensure => 'installed' }
  package { 'tree': ensure => 'installed' }
  package { 'git':  ensure => 'installed' }
  package { 'subversion':  ensure => 'installed' }

}
