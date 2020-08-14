# dotfiles/modules/install.pp

class dotfiles::install (
  $dotfiles_install_path    = undef,
  $dotfiles_install_script  = undef,
  $dotfiles_repository_url = undef,
) {

  case $::operatingsystem {
    'Ubuntu': { $shell_exec_cmd = 'bash' }
    default: { $shell_exec_cmd = 'sh' }
  }

  vcsrepo { 'clone_dotfiles':
    ensure   => present,
    path     => $dotfiles_install_path,
    provider => git,
    source   => $dotfiles_repository_url
  }

  exec { 'install_dotfiles':
    path    => '/bin',
    command => "${shell_exec_cmd} ${dotfiles_install_path}/${dotfiles_install_script}",
    require => VCSREPO['clone_dotfiles']
  }

}
