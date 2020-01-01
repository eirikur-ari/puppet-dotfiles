# dotfiles/modules/init.pp

class dotfiles (

  $github_ssh_key            = $dotfiles::params::github_ssh_key,
  $ssh_config_dir            = $dotfiles::params::ssh_config_dir,
  $ssh_known_hosts_file_path = $dotfiles::params::ssh_known_hosts_file_path,
  $dotfiles_install_path     = $dotfiles::params::dotfiles_install_path,
  $dotfiles_install_script   = $dotfiles::params::dotfiles_install_script,
  $dotfiles_repository_url   = $dotfiles::params::dotfiles_repository_url,
  $epel_release_source       = $dotfiles::params::epel_release_source,

) inherits dotfiles::params {

  validate_string($github_ssh_key)
  validate_string($ssh_config_dir)
  validate_string($ssh_known_hosts_file_path)
  validate_string($dotfiles_install_path)
  validate_string($dotfiles_install_script)
  validate_string($dotfiles_repository_url)
  validate_string($epel_release_source)

  anchor { 'dotfiles::begin': }
  -> class { 'dotfiles::install':
    epel_release_source     => $epel_release_source,
  }
  -> class { 'dotfiles::config':
    github_ssh_key            => $github_ssh_key,
    ssh_known_hosts_file_path => $ssh_known_hosts_file_path,
    ssh_config_dir            => $ssh_config_dir,
    dotfiles_install_path     => $dotfiles_install_path,
    dotfiles_repository_url   => $dotfiles_repository_url,
    dotfiles_install_script   => $dotfiles_install_script,
  }
  -> anchor { 'dotfiles::end': }

}
