# my_dotfiles/modules/init.pp

class my_dotfiles (

  $github_ssh_key            = $my_dotfiles::params::github_ssh_key,
  $ssh_config_dir            = $my_dotfiles::params::ssh_config_dir,
  $ssh_known_hosts_file_path = $my_dotfiles::params::ssh_known_hosts_file_path,
  $dotfiles_install_path     = $my_dotfiles::params::dotfiles_install_path,
  $dotfiles_install_script   = $my_dotfiles::params::dotfiles_install_script,
  $dotfiles_repository_url   = $my_dotfiles::params::dotfiles_repository_url,
  $epel_release_source       = $my_dotfiles::params::epel_release_source,

) inherits my_dotfiles::params {

  validate_string($github_ssh_key)
  validate_string($ssh_config_dir)
  validate_string($ssh_known_hosts_file_path)
  validate_string($dotfiles_install_path)
  validate_string($dotfiles_install_script)
  validate_string($dotfiles_repository_url)
  validate_string($epel_release_source)

  anchor { 'my_dotfiles::begin': }
  -> class { 'my_dotfiles::install':
    epel_release_source => $epel_release_source,
  }
  -> class { 'my_dotfiles::config':
    github_ssh_key            => $github_ssh_key,
    ssh_known_hosts_file_path => $ssh_known_hosts_file_path,
    ssh_config_dir            => $ssh_config_dir,
    dotfiles_install_path     => $dotfiles_install_path,
    dotfiles_repository_url   => $dotfiles_repository_url,
    dotfiles_install_script   => $dotfiles_install_script,
  }
  -> anchor { 'my_dotfiles::end': }

}
