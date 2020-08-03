# /spec/classes/install_spec.rb

require 'spec_helper'

describe 'dotfiles::install' do

  context 'ensures the epel-release yum repo is created' do
    let(:params) do {
      :epel_release_source => "http://test"
    } end
    let(:facts) do {
      :operatingsystem => 'CentOS'
    } end

    it { should contain_package('epel-release').with(:ensure => 'present', :provider => 'rpm', :source => 'http://test') }
  end

  context 'ensure that git is installed' do
      it { should contain_package('git').with(:ensure => 'installed')}
  end

  context 'ensure that pygments is installed' do
    it { should contain_package('pygments').with(:ensure => 'present', :require  => 'Package[python-pip]')}
  end

  context 'ensure that python-pip is installed' do
    it { should contain_package('python-pip').with(:ensure => 'installed')}
  end

  context 'ensures that python-pip is installed using the epel repository for CentOS' do
    let(:facts) do {
      :operatingsystem => 'CentOS'
    } end

    it { should contain_package('python-pip').with(:ensure => 'installed', :require => 'Package[epel-release]')}
  end

  context 'ensure that subversion is installed' do
    it { should contain_package('subversion').with(:ensure => 'installed')}
  end

  context 'ensure that tree is installed' do
    it { should contain_package('tree').with(:ensure => 'installed')}
  end

  context 'ensure that vim is installed' do
    it { should contain_package('vim').with(:ensure => 'installed')}
  end
end
