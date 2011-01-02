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
    gem.add_runtime_dependency("activesupport", ">= 3.0.0")
    gemspec.add_development_dependency "rspec", ">= 2.0.1"
    gemspec.add_development_dependency "rspec-core", ">= 2.0.1"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end