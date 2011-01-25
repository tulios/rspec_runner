module RSpecRunner
  class Config
    
    attr_reader :options
    
    def initialize args
      @args, @options = args, OpenStruct.new
      load_options
      
      # Check if everythig is ok
      unless @options.descriptor_path
        puts "you don't have a descriptor.yml, please run:"
        puts "#{' '*3}spec_runner --install"
        puts "\nor define the descriptor path:"
        puts "#{' '*3}spec_runner --file path/descriptor.yml"
        puts "\ntry spec_runner --help"
        exit(1)
      end
    end
    
    def descriptor
      @options.descriptor
    end
    
    def default_descriptor?
      File.exist?(File.join(@options.project_path, 'spec', 'descriptor.yml'))
    end
    
    private
    def load_options
      @options.project_path = File.expand_path('.')
      @options.templates_path = File.join(File.dirname(__FILE__), "..", "..", "templates")
    
      if default_descriptor?
        @options.descriptor_path = File.expand_path(File.join(@options.project_path, 'spec', 'descriptor.yml'))
        load_descriptor
      end
    
      opts = OptionParser.new do |opts|

        opts.on("-f", "--file FILE", "File descriptor path (Default: spec/descriptor.yml)") do |file_descriptor|
          @options.descriptor_path = file_descriptor
          load_descriptor
        end
      
        opts.on("-g", "--group NAME", "The name of the execution group") do |name|
          @options.execution_group_name = name
          @options.execute = @options.execution_group_name
        end
        
        opts.on("-i", "--install", "Create the descriptor.yml file if you don't have one") do
          genetaror = RSpecRunner::Generator::DescriptorGenerator.new(@options.templates_path, @options.project_path)
          genetaror.generate!
          exit(0)
        end
        
        opts.on("-v", "--version", "The gem version") do
          puts(File.open(File.expand_path(File.join(__FILE__, "..", "..", "..", "VERSION"))).read)
          exit(0)
        end
      end
    
      opts.parse!(@args)
    end
    
    def load_descriptor
      @options.descriptor ||= YAML.load(File.open(@options.descriptor_path).read)
      @options.execute = descriptor["default"]
    end
    
  end
end