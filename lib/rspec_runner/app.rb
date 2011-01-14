module RSpecRunner
  class App
    
    def initialize config
      @config = config
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
    
    private
    
    def extract_files_and_examples
      group_options = @config.options.descriptor[@config.options.execute]
      
      @config.options.files = []
      @config.options.examples = []
      
      group_options.each do |group_option|
        if group_option.class == Hash
          file_name = group_option.keys.first       
          if group_option[file_name].class == Array
            @config.options.examples += group_option[file_name]
          else            
            @config.options.examples << group_option[file_name]
          end
          
          @config.options.files << file_name
        else
          @config.options.files << group_option
        end
      end
    end
    
  end
end