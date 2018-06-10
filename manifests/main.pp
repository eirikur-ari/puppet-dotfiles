node default {

  package { 'epel-release':
    ensure   => 'present',
    provider => 'rpm',
    source   => 'http://fedora.skyggnir.is/epel/epel-release-latest-7.noarch.rpm',
  }

  package { 'vim':  ensure => 'installed' }
  package { 'tree': ensure => 'installed' }
  package { 'git':  ensure => 'installed' }
  package { 'python-pip': ensure => 'installed', require => Package['epel-release'] }
  package { 'pygments': ensure => 'present', provider => 'pip', require  => Package['python-pip']}

  file { 'ssh_known_hosts':
    ensure  => 'present',
    path    => '/etc/ssh/ssh_known_hosts',
    replace => 'no',
    mode    => '0644'
  }

  exec { 'add_github_to_known_hosts':
    path    => '/usr/bin',
    command => 'ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts',
    require => File['ssh_known_hosts']
  }

  vcsrepo { '/usr/local/share/dotfiles':
    ensure            => present,
    provider          => git,
    source            => 'git@github.com:eirikur-ari/dotfiles.git',
    trust_server_cert => true,
    require           => [ Package['git'], Package['pygments'] , Exec['add_github_to_known_hosts'] ]
  }
}
