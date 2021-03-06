# dotfiles/modules/install.pp

class dotfiles::install (
  $dotfiles_install_path   = undef,
  $dotfiles_install_script = undef,
  $dotfiles_repository_url = undef,
  $use_ssh_key             = false,
) {

  case $::operatingsystem {
    'Ubuntu': { $shell_exec_cmd = 'bash' }
    default: { $shell_exec_cmd = 'sh' }
  }

  if $use_ssh_key {
    $initialize_submodules = true
    $install_requirements = Vcsrepo['clone_dotfiles']
  } else {
    $initialize_submodules = false
    $install_requirements = [ Vcsrepo['clone_dotfiles'], Exec['update_gitmodules'] ]
  }

  vcsrepo { 'clone_dotfiles':
    ensure     => present,
    path       => $dotfiles_install_path,
    provider   => git,
    source     => $dotfiles_repository_url,
    submodules => $initialize_submodules,
  }

  if $use_ssh_key == false {

    exec { 'gitmodules_git_ssh_to_https':
      path    => '/bin',
      cwd     => $dotfiles_install_path,
      command => 'sed -i "s/git@github.com:/https:\/\/github.com\//" .gitmodules',
      require => Vcsrepo['clone_dotfiles']
    }

    exec { 'gitmodules_plain_git_to_https':
      path    => '/bin',
      cwd     => $dotfiles_install_path,
      command => 'sed -i "s/git:\/\/github.com\//https:\/\/github.com\//" .gitmodules',
      require => Vcsrepo['clone_dotfiles']
    }

    exec { 'update_gitmodules':
      path    => '/usr/bin',
      cwd     => $dotfiles_install_path,
      command => 'git submodule update --init --recursive',
      require => [ Exec['gitmodules_git_ssh_to_https'], Exec['gitmodules_plain_git_to_https'] ]
    }
  }

  exec { 'install_dotfiles':
    path    => '/bin',
    command => "${shell_exec_cmd} ${dotfiles_install_path}/${dotfiles_install_script}",
    require => $install_requirements
  }

}
