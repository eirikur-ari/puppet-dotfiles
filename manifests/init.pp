# my_workstation_setup/manifests/init.pp

class my_workstation_setup (

  $github_ssh_key            = $my_workstation_setup::params::github_ssh_key,
  $ssh_known_hosts_file_path = $my_workstation_setup::params::ssh_known_hosts_file_path,
  $dotfiles_install_path     = $my_workstation_setup::params::dotfiles_install_path,
  $dotfiles_repository_url   = $my_workstation_setup::params::dotfiles_repository_url,

) inherits my_workstation_setup::params {

  anchor { 'my_workstation_setup::begin': }
  -> class { 'my_workstation_setup::install': }
  -> class { 'my_workstation_setup::config': }
  -> anchor { 'my_workstation_setup::end': }

}