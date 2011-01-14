module RSpecRunner
  class Config
    
    attr_reader :options
    
    def initialize args
      @args = args
      load_options
    end
    
    def descriptor
      @options.descriptor
    end
    
    def default_descriptor?
      File.exist?(File.join(@options.project_path, 'spec', 'descriptor.yml'))
    end
    
    private
    def load_options
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

        # TODO: Isso tem que ficar em outro lugar (quebrar o app?)
        # Version
        #
        # opts.on("-v", "--version", "The version of gem") do
        #   puts(File.open(File.expand_path(File.join(__FILE__, "..", "..", "..", "VERSION"))).read)
        # end
      end
    
      opts.parse!(@args)
      puts "Descriptor: #{@options.descriptor_path}"
    end
    
    def load_descriptor
      @options.descriptor ||= YAML.load(File.open(@options.descriptor_path).read)
      @options.execute = descriptor["default"]
    end
    
  end
end