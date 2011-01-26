module RSpecRunner
  class App
    
    attr_reader :config
    
    def initialize config
      @config = config
      @config.options.files = []
      @config.options.examples = []
    end
    
    def start!
      extract_files_and_examples
    end
    
    def files
      @config.options.files
    end
    
    def examples
      @config.options.examples
    end
    
    def execute
       @config.options.execute
    end
    
    def open_in_browser?
      @config.descriptor["open_in_browser"]
    end
    
    private
    
    def extract_files_and_examples
      group_options = @config.descriptor[execute]
      
      group_options.each do |group_option|
        if group_option.class == Hash
          file_name = group_option.keys.first
          extract_examples(group_option, file_name)
          @config.options.files << file_name
          
        else
          @config.options.files << group_option
        end
      end
      
    end
    
    def extract_examples group_option, file_name
      sample = group_option[file_name]
      if sample.class == Array and not sample.empty?
        @config.options.examples += sample
        
      elsif sample
        @config.options.examples << sample
      end
    end
    
  end
end





















