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
    
    def open_in_browser?
      @config.descriptor["open_in_browser"]
    end
    
    private
    
    def extract_files_and_examples
      group_options = @config.options.descriptor[@config.options.execute]
      
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
      if group_option[file_name].class == Array  and not group_option[file_name].empty?
        @config.options.examples += group_option[file_name]
        
      elsif group_option[file_name]
        @config.options.examples << group_option[file_name]
      end
    end
    
  end
end