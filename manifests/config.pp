# dotfiles/modules/config.pp

class dotfiles::config (
  $dotfiles_install_path     = '',
  $dotfiles_install_script   = '',
  $dotfiles_repository_url   = '',
  $github_ssh_key            = '',
  $ssh_config_dir            = '',
  $ssh_known_hosts_file_path = '',
) {

  case $::operatingsystem {
    'Ubuntu': { $shell_exec_cmd = 'bash' }
    default: { $shell_exec_cmd = 'sh' }
  }

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

  file { 'create_ssh_config_dir':
    ensure => 'directory',
    path   => $ssh_config_dir
  }

  file { 'ssh_config':
    ensure  => file,
    path    => "${ssh_config_dir}/config",
    content => template('dotfiles/.ssh/config.erb'),
    require => File['create_ssh_config_dir']
  }

  vcsrepo { 'clone_dotfiles':
    ensure   => present,
    path     => $dotfiles_install_path,
    provider => git,
    source   => $dotfiles_repository_url,
    require  => [ Exec['add_github_to_known_hosts'], File['ssh_config'] ]
  }

  exec { 'install_dotfiles':
    path    => '/bin',
    command => "${shell_exec_cmd} ${dotfiles_install_path}/${dotfiles_install_script}",
    require => VCSREPO['clone_dotfiles']
  }
}
