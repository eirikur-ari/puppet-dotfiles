require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  module_name = module_root.split('-').last

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => module_root, :module_name => module_name)
      on host, puppet('module install puppetlabs-stdlib'), {:acceptable_exit_codes => [0,1]}
      on host, puppet('module install puppetlabs-vcsrepo'), {:acceptable_exit_codes => [0,1]}
    end
  end
end