source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development do
  gem "travis",               :require => false
  gem "beaker-hostgenerator", :require => false
end

group :test do
  gem "metadata-json-lint",     :require => false
  gem "puppetlabs_spec_helper", :require => false
  gem "rspec-puppet-facts",     :require => false
  gem "rubocop",                :require => false
end

group :system_test do
  gem "beaker",                       :require => false
  gem "beaker-docker",                :require => false
  gem "beaker-rspec",                 :require => false
  gem "beaker-puppet_install_helper", :require => false
end

group :release do
  gem 'puppet-blacksmith', :require => false
end

gem "puppet", ENV['PUPPET_VERSION'] || '~> 5.0', :require => false