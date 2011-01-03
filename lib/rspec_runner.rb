# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift(File.dirname(__FILE__))

begin
  require 'active_support'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'activesupport', ">= 3.0.0"
  require 'active_support'
end

require 'tempfile'
require 'rbconfig'
require 'rake'
require 'optparse'
require 'ostruct'
require 'yaml'
require 'spec/autorun'

# RSpecRunner::Opener.open(RSpecRunner.run_files(files))
#
module RSpecRunner
  autoload :Runner,     'rspec_runner/runner'
  autoload :Opener,     'rspec_runner/opener'
  autoload :Exceptions, 'rspec_runner/exceptions'
  autoload :App,        'rspec_runner/app'
end

RSpecRunner.send :extend, RSpecRunner::Runner