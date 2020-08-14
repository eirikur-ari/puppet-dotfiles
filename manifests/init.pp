# dotfiles/modules/init.pp

class dotfiles (

  $dotfiles_install_path     = $dotfiles::params::dotfiles_install_path,
  $dotfiles_install_script   = $dotfiles::params::dotfiles_install_script,
  $dotfiles_repository_url   = $dotfiles::params::dotfiles_repository_url,
  $epel_release_source       = $dotfiles::params::epel_release_source,
  $github_ssh_key            = $dotfiles::params::github_ssh_key,
  $ssh_config_dir            = $dotfiles::params::ssh_config_dir,
  $ssh_known_hosts_file_path = $dotfiles::params::ssh_known_hosts_file_path,

) inherits dotfiles::params {

  validate_string($dotfiles_install_path)
  validate_string($dotfiles_install_script)
  validate_string($dotfiles_repository_url)
  validate_string($github_ssh_key)
  validate_string($epel_release_source)
  validate_string($ssh_config_dir)
  validate_string($ssh_known_hosts_file_path)

  anchor { 'dotfiles::begin': }
  -> class { 'dotfiles::package':
    epel_release_source => $epel_release_source,
  }
  -> class { 'dotfiles::config':
    dotfiles_install_path     => $dotfiles_install_path,
    dotfiles_install_script   => $dotfiles_install_script,
    dotfiles_repository_url   => $dotfiles_repository_url,
    github_ssh_key            => $github_ssh_key,
    ssh_config_dir            => $ssh_config_dir,
    ssh_known_hosts_file_path => $ssh_known_hosts_file_path,
  }
  -> class { 'dotfiles::install': }
  -> anchor { 'dotfiles::end': }

}
