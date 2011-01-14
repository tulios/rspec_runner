# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'tempfile'
require 'rbconfig'
require 'rake'
require 'optparse'
require 'ostruct'
require 'yaml'
require 'spec/autorun'

require File.join(File.dirname(__FILE__), 'gem_chooser')
GemChooser.load_gems

module RSpecRunner
  autoload :Config,     'rspec_runner/config'
  autoload :App,        'rspec_runner/app'
  autoload :Runner,     'rspec_runner/runner'
  autoload :Opener,     'rspec_runner/opener'
  autoload :Exceptions, 'rspec_runner/exceptions'
  
  def self.get_output
    stdout = File.open("#{output_path}/rspec_runner_#{Time.now.to_i}.html", "w")
    stdout.sync = true
    stdout
  end
  
  def self.output_path
    Dir.tmpdir
  end
  
  def self.delete_old_outputs
    entries = Dir.new(output_path).entries.select {|entry| entry =~ /^rspec_runner_/}
    entries.each do |entry|
      File.delete File.expand_path(File.join(output_path, entry))
    end
  end
  
end

RSpecRunner.send :extend, RSpecRunner::Runner