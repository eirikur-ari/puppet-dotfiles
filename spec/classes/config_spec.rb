# /spec/classes/config_spec.rb

require 'spec_helper'

describe 'my_workstation_setup::config' do
  let(:params) {{
    :github_ssh_key            => 'test_rsa',
    :ssh_known_hosts_file_path => 'test/ssh_known_hosts',
    :ssh_config_dir            => 'test/.ssh',
    :dotfiles_install_path     => '',
    :dotfiles_repository_url   => '',
    :dotfiles_install_script   => '',
  }}

  context 'ensures that the file ssh_known_hosts is present and configured' do
    it { should contain_file("ssh_known_hosts").with(:ensure => 'present', :path => 'test/ssh_known_hosts' ) }
    it { should contain_exec("add_github_to_known_hosts").with(:command => 'ssh-keyscan -t rsa github.com >> test/ssh_known_hosts') }
  end

  # TODO: finish implementing test
  context 'ensure that the ssh config file is configured' do
    it { should contain_file("ssh_config").with(:path => 'test/.ssh/config' ) }
  end
end