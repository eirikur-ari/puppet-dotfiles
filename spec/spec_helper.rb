require 'rspec-puppet/spec_helper'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  # Setup
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')

  # Coverage generation
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end

  # Facts
  c.default_facts = {
    :architecture => 'x86_64',
    :operatingsystem => 'centos',
    :osfamily => 'RedHat',
    :operatingsystemrelease => '7',
    :kernel => 'Linux',
  }
end

Puppet::Util::Log.level = :debug
Puppet::Util::Log.newdestination(:console)
