module GemChooser
      
  class << self
    
    def load_gems
      rails? ? load_project_context : load_gem('active_support', 'activesupport')
      load_gem 'rainbow', 'rainbow'
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
  
    private
    def load_gem name, gem_name
      begin
        require name
      rescue LoadError
        require 'rubygems' unless ENV['NO_RUBYGEMS']
        gem gem_name
        require name
      end
    end
  
  end
end