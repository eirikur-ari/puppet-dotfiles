# Use default configuration during testing
include dotfiles

# Clone using ssh key
# node default {
#   class { 'dotfiles':
#     dotfiles_repository_url => 'git@github.com:eirikur-ari/dotfiles.git',
#     use_ssh_key             => true,
#   }
# }

# Example of available configuraiton
# node default {
#  class { 'dotfiles':
#    github_ssh_key            => 'example_rsa_key',
#    ssh_known_hosts_file_path => 'example/ssh_known_hosts',
#    ssh_config_dir            => 'example/.ssh',
#    dotfiles_install_path     => 'example/dotfiles',
#    dotfiles_repository_url   => 'git@some.repo:example/dotfiles.git',
#    dotfiles_install_script   => 'example.sh',
#    use_ssh_key               => true,
#  }
# }
