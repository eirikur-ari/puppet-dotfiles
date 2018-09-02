# my_workstation_setup/modules/init.pp

class my_workstation_setup (

  $github_ssh_key            = $my_workstation_setup::params::github_ssh_key,
  $ssh_config_dir            = $my_workstation_setup::params::ssh_config_dir,
  $ssh_known_hosts_file_path = $my_workstation_setup::params::ssh_known_hosts_file_path,
  $dotfiles_install_path     = $my_workstation_setup::params::dotfiles_install_path,
  $dotfiles_install_script   = $my_workstation_setup::params::dotfiles_install_script,
  $dotfiles_repository_url   = $my_workstation_setup::params::dotfiles_repository_url,
  $epel_release_source       = $my_workstation_setup::params::epel_release_source,

) inherits my_workstation_setup::params {

  # TODO: Verify params

  anchor { 'my_workstation_setup::begin': }
  -> class { 'my_workstation_setup::install':
    epel_release_source => $epel_release_source,
  }
  -> class { 'my_workstation_setup::config':
    github_ssh_key            => $github_ssh_key,
    ssh_known_hosts_file_path => $ssh_known_hosts_file_path,
    ssh_config_dir            => $ssh_config_dir,
    dotfiles_install_path     => $dotfiles_install_path,
    dotfiles_repository_url   => $dotfiles_repository_url,
    dotfiles_install_script   => $dotfiles_install_script,
  }
  -> anchor { 'my_workstation_setup::end': }

}