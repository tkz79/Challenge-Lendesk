require 'bundler'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rake/clean'
require 'rubygems/package_task'

spec = eval(File.read('image_gps.gemspec'))
Gem::PackageTask.new(spec) do |pkg| end

  Bundler::GemHelper.install_tasks

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features"
    t.fork = false
  end

  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
