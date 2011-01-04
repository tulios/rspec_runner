begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "rspec_runner"
    gemspec.summary = "GUI Runner for RSpec tests"
    gemspec.description = "GUI Runner for RSpec tests"
    gemspec.email = "ornelas.tulio@gmail.com"
    gemspec.homepage = "http://github.com/tulios/rspec_runner"
    gemspec.authors = ["Túlio Ornelas"]
    gemspec.test_files = Dir.glob('spec/*_spec.rb')
    gemspec.add_runtime_dependency("activesupport", "2.3.8")
    # gemspec.add_development_dependency "rspec", ">= 2.0.1"
    # gemspec.add_development_dependency "rspec-core", ">= 2.0.1"
    gemspec.executables = ['spec_runner']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

# require 'rspec/core/rake_task'
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
end
