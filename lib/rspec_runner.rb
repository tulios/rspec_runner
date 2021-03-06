# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'tempfile'
require 'rbconfig'
require 'rake'
require 'optparse'
require 'ostruct'
require 'yaml'

# Rspec 1.3
require 'spec/autorun'
require 'spec/runner/formatter/html_formatter'
             
require 'rainbow'
require 'erb'

require File.join(File.dirname(__FILE__), 'gem_chooser')

module RSpecRunner
  autoload :Config,     'rspec_runner/config'
  autoload :App,        'rspec_runner/app'
  autoload :Runner,     'rspec_runner/runner'
  
  module Formatter
    autoload :TextAndHtmlFormatter, 'rspec_runner/formatter/text_and_html_formatter'
  end
  
  module Generator
    autoload :DescriptorGenerator,  'rspec_runner/generator/descriptor_generator'
  end

  extend RSpecRunner::Runner
    
  def self.init!(config)
    puts "Descriptor: #{config.options.descriptor_path}"
    GemChooser.load_gems
    
    app = App.new config
    app.start!

    puts "Running group: #{app.execute.color(:cyan)}"
    puts "Files: #{app.files.inspect}"
    puts "Examples: #{app.examples.inspect}" unless app.examples.empty?

    delete_old_outputs
    output = get_output

    puts "output: #{output.path}" if app.open_in_browser?
    puts "\n"
               
    run_file_list(app.files, app.examples, output)
    open_in_browser(output.path) if app.open_in_browser?
  end
  
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
    entries.each {|entry| File.delete File.expand_path(File.join(output_path, entry))}
  end
  
  def self.open_in_browser path
    require "launchy"
    Launchy::Browser.run(path)
  rescue LoadError
    warn "Sorry, you need to install launchy to open pages: `gem install launchy`"
  end
  
end