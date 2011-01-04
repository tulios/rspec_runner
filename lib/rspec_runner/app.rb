module RSpecRunner
  class App
    
    attr_reader :options
    
    def initialize args
      @args = args
    end           
    
    def start!
      @options = OpenStruct.new
      @options.project_path = File.expand_path('.')
      
      if default_descriptor?
        @options.descriptor_path = File.expand_path(File.join(@options.project_path, 'spec', 'descriptor.yml'))
        load_descriptor
      end
      
      opts = OptionParser.new do |opts|
        # Path do arquivo que descreve os grupos de execucao
        #
        opts.on("-f", "--file FILE", "File descriptor path (Default: spec/descriptor.yml)") do |file_descriptor|
          @options.descriptor_path = file_descriptor
          load_descriptor
        end
        
        # Qual grupo de execucao rodar
        #
        opts.on("-g", "--group NAME", "The name of the execution group") do |name|
          @options.execution_group_name = name
          @options.execute = @options.execution_group_name
        end
      end
      
      opts.parse!(@args)
      puts "Descriptor: #{@options.descriptor_path}"
      
      extract_files_and_examples
      load_project_context
    end
    
    def descriptor
      @options.descriptor
    end
    
    def files
      @options.files
    end
    
    def examples
      @options.examples
    end
    
    private
    
    def load_descriptor
      @options.descriptor ||= YAML.load(File.open(@options.descriptor_path).read)
      @options.execute = descriptor["default"]
    end
    
    def default_descriptor?
      File.exist?(File.join(@options.project_path, 'spec', 'descriptor.yml'))
    end
    
    def rails?
      File.exist?(File.join(@options.project_path, 'config', 'boot.rb'))
    end
    
    def load_project_context
      puts "Loading project context"
      if rails?
        ENV['RAILS_ENV'] = "test"
        require File.expand_path(File.join(@options.project_path, "config", "environment"))
      end
    end
    
    def extract_files_and_examples
      group_options = @options.descriptor[@options.execute]
      
      @options.files = []
      @options.examples = []
      
      group_options.each do |group_option|
        if group_option.class == Hash
          file_name = group_option.keys.first       
          if group_option[file_name].class == Array
            @options.examples += group_option[file_name]
          else            
            @options.examples << group_option[file_name]
          end
          
          @options.files << file_name
        else
          @options.files << group_option
        end
      end
    end
    
  end
end