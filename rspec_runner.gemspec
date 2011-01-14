# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec_runner}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["T\303\272lio Ornelas"]
  s.date = %q{2011-01-13}
  s.default_executable = %q{spec_runner}
  s.description = %q{Add suite of tests feature on RSpec, show the results with html format (nice =])}
  s.email = %q{ornelas.tulio@gmail.com}
  s.executables = ["spec_runner"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/spec_runner",
     "lib/gem_chooser.rb",
     "lib/rspec_runner.rb",
     "lib/rspec_runner/app.rb",
     "lib/rspec_runner/config.rb",
     "lib/rspec_runner/exceptions.rb",
     "lib/rspec_runner/opener.rb",
     "lib/rspec_runner/runner.rb",
     "resources/descriptor.yml",
     "resources/example1_spec.rb",
     "resources/example2_spec.rb",
     "rspec_runner.gemspec",
     "script/console",
     "spec/rspec_runner_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/tulios/rspec_runner}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Add suite of tests feature on RSpec}
  s.test_files = [
    "spec/rspec_runner_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

