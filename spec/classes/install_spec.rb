# /spec/classes/install_spec.rb

require 'spec_helper'

describe 'dotfiles::install' do
    
  context 'ensure that my dotfile will be cloned and installed using http by default' do
    let(:params) do {
      :dotfiles_install_path   => 'test/dotfiles',
      :dotfiles_repository_url => 'https://test.repo/test/dotfiles.git',
      :dotfiles_install_script => 'test.sh',
    } end

    it { should contain_vcsrepo('clone_dotfiles').with(:ensure => 'present', 
                                                       :path => 'test/dotfiles', 
                                                       :source => 'https://test.repo/test/dotfiles.git', 
                                                       :submodules => false) 
    }
    
    it { should contain_exec('install_dotfiles').with(:require => '[Vcsrepo[clone_dotfiles]{:path=>"clone_dotfiles"}, Exec[update_gitmodules]{:command=>"update_gitmodules"}]') }

    it { should contain_exec('rename_protocol_git_ssh_to_https').with(:command => 'sed -i "s/git@github.com:/https:\/\/github.com\//" .gitmodules', 
                                                                      :require => 'Vcsrepo[clone_dotfiles]') 
    }

    it { should contain_exec('rename_protocol_plain_git_to_https').with(:command => 'sed -i "s/git:\/\/github.com\//https:\/\/github.com\//" .gitmodules', 
                                                                        :require => 'Vcsrepo[clone_dotfiles]')     
    }

    it { should contain_exec('update_gitmodules').with(:command => 'git submodule update --init --recursive',
                                                       :require => '[Exec[rename_protocol_git_ssh_to_https]{:command=>"rename_protocol_git_ssh_to_https"}, Exec[rename_protocol_plain_git_to_https]{:command=>"rename_protocol_plain_git_to_https"}]') 
    }
  end

  context 'ensure that my dotfiles will be cloned and installed using ssh key' do
    let(:params) do {
      :dotfiles_install_path   => 'test/dotfiles',
      :dotfiles_repository_url => 'git@test.repo:test/dotfiles.git',
      :dotfiles_install_script => 'test.sh',
      :use_ssh_key             => true,
    } end
    
    it { should contain_vcsrepo('clone_dotfiles').with(:ensure => 'present', 
                                                       :path => 'test/dotfiles', 
                                                       :source => 'git@test.repo:test/dotfiles.git', 
                                                       :submodules => true) 
    }

    it { should contain_exec('install_dotfiles').with(:require => 'Vcsrepo[clone_dotfiles]') }

    it { should_not contain_exec('rename_protocol_git_ssh_to_https') }

    it { should_not contain_exec('rename_protocol_plain_git_to_https') }

    it { should_not contain_exec('update_gitmodules') }
  end    
    
  context 'ensure that the sh command will be used to execute install scripts by default' do
    let(:params) do {
      :dotfiles_install_path   => 'test/dotfiles',
      :dotfiles_install_script => 'test.sh',
    } end
    let(:facts) do {
      :operatingsystem => ''
    } end

    it { should contain_exec('install_dotfiles').with(:command => "sh test/dotfiles/test.sh")}
  end

  context 'ensure that the bash command will be used to execute install scripts on Ubuntu' do
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
