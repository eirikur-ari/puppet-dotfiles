source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem "metadata-json-lint",     :require => false
  gem "puppetlabs_spec_helper", :require => false
  gem "rspec-puppet-facts",     :require => false
  gem "rubocop",                :require => false
end

gem "puppet", ENV['PUPPET_VERSION'] || '~> 4.10.11'