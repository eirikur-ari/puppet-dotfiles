# /spec/classes/init_spec.rb

require 'spec_helper'

describe 'dotfiles' do

  context 'should contain classes' do
    it{ should contain_anchor('dotfiles::begin')}
    it{ should contain_class('dotfiles::params') }
    it{ should contain_class('dotfiles::package') }
    it{ should contain_class('dotfiles::config') }
    it{ should contain_class('dotfiles::install') }
    it{ should contain_anchor('dotfiles::end')}
  end

end
