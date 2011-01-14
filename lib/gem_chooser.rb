module GemChooser
      
  class << self
    
    def load_gems
      rails? ? load_project_context : load_active_support
    end
  
    def rails?
      File.exist?(File.join(File.expand_path('.'), 'config', 'boot.rb'))
    end
  
    def load_project_context
      puts "Loading project context"
      if rails?
        ENV['RAILS_ENV'] = "test"
        require File.join(File.expand_path('.'), "config", "environment")
      end
    end
  
    def load_active_support
      begin
        require 'active_support'
      rescue LoadError
        require 'rubygems' unless ENV['NO_RUBYGEMS']
        gem 'activesupport'
        require 'active_support'
      end
    end
  
  end
end