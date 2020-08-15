# /spec/classes/config_spec.rb

require 'spec_helper'

describe 'dotfiles::config' do

  context 'ensures that the file ssh_known_hosts is present and configured' do
    let(:params) do {
      :ssh_known_hosts_file_path => 'test/ssh_known_hosts',
    } end

    it { should contain_file('ssh_known_hosts').with(:ensure => 'present', :path => 'test/ssh_known_hosts' ) }

    it { should contain_exec('add_github_to_known_hosts').with(:command => 'ssh-keyscan -t rsa github.com >> test/ssh_known_hosts') }
  end

  context 'ensure that the ssh config file is configured' do
    let(:params) do {
      :github_ssh_key => 'test_rsa',
      :ssh_config_dir => 'test/.ssh',
      :use_ssh_key    => true,
    } end

    it { should contain_file('create_ssh_config_dir').with(:ensure => 'directory', :path => 'test/.ssh') }

    it { should contain_file('ssh_config').with(:path => 'test/.ssh/config', :require => 'File[create_ssh_config_dir]')
                                          .with_content(/test\/.ssh\/test_rsa/) 
    }
  end

  context 'ensure that the ssh config file is not configured by default' do
    it { should_not contain_file('ssh_config') }
  end

end