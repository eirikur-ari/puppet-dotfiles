# my_workstation_setup/modules/config.pp

class my_workstation_setup::config {
  file { 'ssh_known_hosts':
    ensure  => 'present',
    path    => $my_workstation_setup::ssh_known_hosts_file_path,
    replace => 'no',
    mode    => '0644'
  }

  #TODO: This needs to be done differently. The RSA is currently echoed each time puppet runs.
  exec { 'add_github_to_known_hosts':
    path    => '/usr/bin',
    command => "ssh-keyscan -t rsa github.com >> ${my_workstation_setup::ssh_known_hosts_file_path}",
    require => File['ssh_known_hosts']
  }

  vcsrepo { 'clone_dotfiles':
    ensure   => present,
    path     => $my_workstation_setup::dotfiles_install_path,
    provider => git,
    source   => $my_workstation_setup::dotfiles_repository_url,
    require  => [ Package['git'], Package['pygments'] , Exec['add_github_to_known_hosts'] ]
  }

  #TODO: Currently the dotfiles are only installed for current running user
  exec { 'install_dotfiles':
    path    => '/bin',
    command => "sh ${my_workstation_setup::dotfiles_install_path}/${my_workstation_setup::dotfiles_install_script}",
    require => VCSREPO['clone_dotfiles']
  }
}