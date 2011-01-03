module RSpecRunner
  module Runner
                                            
    # ex: run_file "resources/example1_spec.rb"
    #
    def run_file file_name, examples = []
      run :files => [file_name], :examples => examples
    end

    # ex: run_files ["resources/example1_spec.rb", "resources/example2_spec.rb"]
    #
    def run_files files, examples = []
      run :files => files, :examples => examples
    end

    # ex: run_file_list "resources/*_spec.rb"
    #
    def run_file_list file_list, examples = []
      run :files => FileList[file_list].to_a, :examples => examples
    end      
       
    def run options = {:files => [], :examples => []}
      stdout = Tempfile.new(["rspec_runner_#{Time.now.to_i}", ".html"])
      argv = options[:files].sort
      unless options[:examples].empty?
        examples_file = Tempfile.new(["rspec_runner_examples_file_#{Time.now.to_i}", ".txt"])
        examples_file.write(options[:examples].join("\n"))
        examples_file.flush
        examples_file.close
        argv << "--example=#{examples_file.path}"
      end
      argv << "--format=html"
                                        
      Spec::Runner::CommandLine.run(::Spec::Runner::OptionParser.parse(argv, STDERR, stdout))
      stdout.path
    end
    
  end
end