node default {

  package { 'vim':  ensure => 'installed' }
  package { 'tree': ensure => 'installed' }
  package { 'git':  ensure => 'installed' }

  file { '/etc/ssh/ssh_known_hosts':
    ensure  => 'present',
    replace => 'no',
    mode    => '0644'
  }

  exec { 'add_github_to_known_hosts':
    path    => '/usr/bin',
    command => 'ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts',
    require => File['/etc/ssh/ssh_known_hosts']
  }

  vcsrepo { '/usr/local/share/dotfiles':
    ensure            => present,
    provider          => git,
    source            => 'git@github.com:eirikur-ari/dotfiles.git',
    trust_server_cert => true,
    require           => [ Package['git'], Exec['add_github_to_known_hosts'] ]
  }
}
