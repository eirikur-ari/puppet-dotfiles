# my_workstation_setup/manifests/params.pp

class my_workstation_setup::params {

  #TODO: check if the ssh key file exists
  # ssh key's
  $github_ssh_key = 'github_rsa'

  $ssh_known_hosts_file_path = '/etc/ssh/ssh_known_hosts'

  # dotfiles
  $dotfiles_install_path   = '/usr/local/share/dotfiles'
  $dotfiles_repository_url = 'git@github.com:eirikur-ari/dotfiles.git'
  $dotfiles_install_script = 'install.sh'
}