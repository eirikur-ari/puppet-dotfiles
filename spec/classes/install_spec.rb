# /spec/classes/install_spec.rb

require 'spec_helper'

describe 'dotfiles::install' do
    
  context 'ensure that my dofiles will be cloned and installed' do
        let(:params) do {
          :dotfiles_install_path   => 'test/dotfiles',
          :dotfiles_repository_url => 'git@test.repo:test/dotfiles.git',
          :dotfiles_install_script => 'test.sh',
        } end
    
    it { should contain_vcsrepo('clone_dotfiles').with(:ensure => 'present',
                                                       :path => 'test/dotfiles',
                                                       :source => 'git@test.repo:test/dotfiles.git')
    }

    it { should contain_exec('install_dotfiles').with(:command => "sh test/dotfiles/test.sh")}
  end    
    

  context 'ensure that bash will be used to execute the dotfiles install script on Ubuntu' do
    let(:params) do {
      :dotfiles_install_path   => 'test/dotfiles',
      :dotfiles_install_script => 'test.sh',
    } end
    let(:facts) do {
      operatingsystem: 'Ubuntu'
    } end
    
    it { should contain_exec('install_dotfiles').with(:command => "bash test/dotfiles/test.sh")}
  end

end
