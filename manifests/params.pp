# my_workstation_setup/modules/params.pp

class my_workstation_setup::params {

  # ssh key's
  $github_ssh_key = 'github_rsa'
  $ssh_config_dir = '/root/.ssh'

  $ssh_known_hosts_file_path = '/etc/ssh/ssh_known_hosts'

  # dotfiles
  $dotfiles_install_path   = '/usr/local/share/dotfiles'
  $dotfiles_repository_url = 'git@github.com:eirikur-ari/dotfiles.git'
  $dotfiles_install_script = 'install.sh'

  # Yum repositories
  $epel_release_source = 'http://fedora.skyggnir.is/epel/epel-release-latest-7.noarch.rpm'
}