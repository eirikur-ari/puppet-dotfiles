# /spec/classes/init_spec.rb

require 'spec_helper'

describe 'my_dotfiles' do

  context 'should contain classes' do
    it{ should contain_anchor('my_dotfiles::begin')}
    it{ should contain_class('my_dotfiles::params') }
    it{ should contain_class('my_dotfiles::install') }
    it{ should contain_class('my_dotfiles::config') }
    it{ should contain_anchor('my_dotfiles::end')}
  end

end
