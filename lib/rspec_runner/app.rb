module RSpecRunner
  class App
    
    attr_reader :options
    
    def initialize args
      @args = args
    end           
    
    def start!
      @options = OpenStruct.new
      opts = OptionParser.new do |opts|
        
        # Path do arquivo que descreve os grupos de execucao
        #
        opts.on("-f", "--file FILE", "File descriptor path") do |file_descriptor|
          @options.descriptor_path = file_descriptor
          @options.descriptor ||= YAML.load(File.open(@options.descriptor_path).read)
          @options.execute = descriptor["default"]
        end
        
        # Qual grupo de execucao rodar
        #
        opts.on("-g", "--group NAME", "The name of the execution group") do |name|
          @options.execution_group_name = name
          @options.execute = @options.execution_group_name
        end
      end
      
      opts.parse!(@args)
      extract_files_and_examples
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