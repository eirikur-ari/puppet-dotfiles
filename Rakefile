require 'bundler/setup'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'

Rake::Task[:spec_prep].clear
desc "Create the fixtures directory"
task :spec_prep do
  # Setup
  FileUtils::mkdir_p("spec/fixtures/modules")
  FileUtils::mkdir_p("spec/fixtures/manifests")
  FileUtils::touch("spec/fixtures/manifests/site.pp")
  sh "librarian-puppet install --path=spec/fixtures/modules"

  # Add the project as module
  current_dir = Dir.pwd
  module_name = File.basename(current_dir)
  fixture_module_path = "spec/fixtures/modules/#{module_name}"
  FileUtils.rm_f fixture_module_path
  FileUtils::mkdir_p(fixture_module_path)
#  FileUtils.ln_sf "../../../../files", fixture_module_path
  FileUtils.ln_sf "../../../../manifests", fixture_module_path
 # FileUtils.ln_sf "../../../../templates", fixture_module_path
end

Rake::Task[:spec_clean].clear
desc "Cleanup the fixtures directory"
task :spec_clean do
  FileUtils.rm_rf("spec/fixtures/")
end

task :test => [
    :syntax,
    :lint,
    :spec,
]
