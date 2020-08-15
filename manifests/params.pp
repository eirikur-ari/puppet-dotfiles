# dotfiles/modules/params.pp

class dotfiles::params {

  # ssh key's
  $github_ssh_key = 'github_rsa'
  $ssh_config_dir = '/root/.ssh'
  $use_ssh_key    = false

  $ssh_known_hosts_file_path = '/etc/ssh/ssh_known_hosts'

  # dotfiles
  $dotfiles_install_path   = '/usr/local/share/dotfiles'
  $dotfiles_repository_url = 'https://github.com/eirikur-ari/dotfiles.git'

  $dotfiles_install_script = 'install.sh'

  # Yum repositories
  case $::operatingsystem {
    'CentOS': { $epel_release_source = "http://fedora.skyggnir.is/epel/epel-release-latest-${::operatingsystemmajrelease}.noarch.rpm" }
    default: { $epel_release_source = undef }
  }

}
