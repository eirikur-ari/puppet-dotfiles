# /spec/classes/init_spec.rb

require 'spec_helper'

describe 'my_workstation_setup' do
  # TODO: implement tests
  context 'should contain classes' do
    it{ should contain_class('my_workstation_setup::params') }
    it{ should contain_class('my_workstation_setup::install') }
    it{ should contain_class('my_workstation_setup::config') }
  end
end
