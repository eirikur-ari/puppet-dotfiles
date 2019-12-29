source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem "metadata-json-lint"

  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 4.10.11'
  gem "puppet-lint"

  gem "rspec"
  gem "rspec-core"
  gem "rspec-puppet"

  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
  gem "rspec-puppet-facts"
end
