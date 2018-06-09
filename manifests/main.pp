node default {

  package { 'vim':
    ensure => 'installed',
  }

  package { 'tree':
    ensure => 'installed',
  }
}
