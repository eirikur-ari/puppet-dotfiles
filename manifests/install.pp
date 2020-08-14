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
    $install_requirements = VCSREPO['clone_dotfiles']
  } else {
    $initialize_submodules = false
    $install_requirements = [ VCSREPO['clone_dotfiles'], Exec['update_gitmodules'] ]
  }

  vcsrepo { 'clone_dotfiles':
    ensure     => present,
    path       => $dotfiles_install_path,
    provider   => git,
    source     => $dotfiles_repository_url,
    submodules => $initialize_submodules,
  }

  if $use_ssh_key == false {

    exec { 'rename_git_at_github_to_https':
      path    => '/bin',
      cwd     => $dotfiles_install_path,
      command => 'sed -i "s/git@github.com:/https:\/\/github.com\//" .gitmodules',
      require => VCSREPO['clone_dotfiles']
    }

    exec { 'rename_git_slash_github_to_https':
      path    => '/bin',
      cwd     => $dotfiles_install_path,
      command => 'sed -i "s/git:\/\/github.com\//https:\/\/github.com\//" .gitmodules',
      require => VCSREPO['clone_dotfiles']
    }

    exec { 'update_gitmodules':
      path    => '/usr/bin',
      cwd     => $dotfiles_install_path,
      command => 'git submodule update --init --recursive',
      require => [ Exec['rename_git_at_github_to_https'], Exec['rename_git_slash_github_to_https'] ]
    }
  }

  exec { 'install_dotfiles':
    path    => '/bin',
    command => "${shell_exec_cmd} ${dotfiles_install_path}/${dotfiles_install_script}",
    require => $install_requirements
  }

}
