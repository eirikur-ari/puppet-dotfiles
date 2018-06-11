# my_workstation_setup/manifests/config.pp

class my_workstation_setup::config {
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
    ensure   => present,
    provider => git,
    source   => 'git@github.com:eirikur-ari/dotfiles.git',
    require  => [ Package['git'], Package['pygments'] , Exec['add_github_to_known_hosts'] ]
  }

  exec { 'install_dotfiles':
    command => '/bin/sh /usr/local/share/dotfiles/install.sh',
    require => VCSREPO['/usr/local/share/dotfiles']
  }
}