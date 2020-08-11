require 'puppetlabs_spec_helper/rake_tasks'

begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

PuppetLint.configuration.fail_on_warnings = true

exclude_paths = [
  "pkg/**/*",
  "spec/**/*",
  "vendor/**/*",
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

desc "Run syntax, lint and spec tests"
task :test => [
    :metadata_lint,
    :syntax,
    :lint,
    :spec,
]
