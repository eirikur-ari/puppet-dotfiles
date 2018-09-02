# my_workstation_setup/modules/config.pp

class my_workstation_setup::config(
  $github_ssh_key,
  $ssh_known_hosts_file_path,
  $ssh_config_dir,
  $dotfiles_install_path,
  $dotfiles_repository_url,
  $dotfiles_install_script,
) {
  file { 'ssh_known_hosts':
    ensure  => 'present',
    path    => $ssh_known_hosts_file_path,
    replace => 'no',
    mode    => '0644'
  }

  exec { 'add_github_to_known_hosts':
    path    => '/usr/bin',
    command => "ssh-keyscan -t rsa github.com >> ${ssh_known_hosts_file_path}",
    require => File['ssh_known_hosts']
  }

  # TODO: Pass in parameter to the config template
  file { 'ssh_config':
    ensure  => file,
    path    => "${ssh_config_dir}/config",
    content => template('my_workstation_setup/.ssh/config.erb')
  }

  vcsrepo { 'clone_dotfiles':
    ensure   => present,
    path     => $dotfiles_install_path,
    provider => git,
    source   => $dotfiles_repository_url,
    require  => [ Exec['add_github_to_known_hosts'], File['ssh_config'] ]
  }

  #TODO: Currently the dotfiles are only installed for current running user
  exec { 'install_dotfiles':
    path    => '/bin',
    command => "sh ${dotfiles_install_path}/${dotfiles_install_script}",
    require => VCSREPO['clone_dotfiles']
  }
}