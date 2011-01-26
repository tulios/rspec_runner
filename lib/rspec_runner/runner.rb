module RSpecRunner
  module Runner
    
    # ex: run_file_list "resources/*_spec.rb"
    #
    def run_file_list file_list, examples = [], output = get_output
      run :files => FileList[file_list].to_a, :examples => examples, :output => output
    end      
       
    def run options = {:files => [], :examples => [], :output => get_output}
      stdout = options[:output]
      argv = options[:files].sort
      unless options[:examples].empty?
        examples_file = Tempfile.new(["rspec_runner_examples_file_#{Time.now.to_i}", ".txt"])
        examples_file.write(options[:examples].join("\n"))
        examples_file.flush
        examples_file.close
        argv << "--example=#{examples_file.path}"
      end
      argv << "--require=rspec_runner/formatter/text_and_html_formatter.rb"
      argv << "--format=#{format}"
                                        
      Spec::Runner::CommandLine.run(::Spec::Runner::OptionParser.parse(argv, STDERR, stdout))
    end
                
    # This methods helps testability
    def format; @format || RSpecRunner::Formatter::TextAndHtmlFormatter.to_s end
    def format=(format); @format = format end
    
  end
end

































