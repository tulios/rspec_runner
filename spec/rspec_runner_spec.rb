require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSpecRunner do 
  
  before :each do
    @descriptor_path = File.expand_path(File.dirname(__FILE__) + '/resources/descriptor.yml')
  end
  
  context 'when related to RSpecRunner module' do
    
    it 'should generate a new output file' do
      output = RSpecRunner.get_output
      output.should_not be_nil
      File.exist?(output.path).should be_true
    end
    
    it 'should generate an output_path equal to temp dir' do
      RSpecRunner.output_path.should eql(Dir.tmpdir)
    end
    
    it 'should delete old outputs' do
      output = RSpecRunner.get_output
      File.exist?(output.path).should be_true
      
      RSpecRunner.delete_old_outputs
      File.exist?(output.path).should be_false
    end
    
    context 'and related to launchy' do
      before :each do
        require "launchy"
        Launchy::Browser.stub!(:run)
      end                
      
      it "should open the file in a browser" do
        Launchy::Browser.should_receive(:run)
        RSpecRunner.open_in_browser(RSpecRunner.get_output)
      end

      it "should fail gracefully if it is not available" do
        Launchy::Browser.should_receive(:run).and_raise(LoadError)
      
        lambda do
          RSpecRunner.open_in_browser(RSpecRunner.get_output)
        end.should_not raise_error
      end
    end
        
  end
  
  context 'when related to runner' do
    
    it 'should have text_and_html as the default format' do
      RSpecRunner.format.should eql(RSpecRunner::Formatter::TextAndHtmlFormatter.to_s)
    end

    it "should have the method run" do
      RSpecRunner.methods.member?("run").should be_true
    end                            
  
    it 'should run a list of tests' do
      files = []
      files << File.expand_path(File.dirname(__FILE__) + '/resources/example1_spec.rb')
      files << File.expand_path(File.dirname(__FILE__) + '/resources/example2_spec.rb')
      
      RSpecRunner.format = 'silent'
      RSpecRunner.format.should eql('silent')
      stdout = RSpecRunner.run_file_list files
      stdout.should_not be_nil
    end
  
  end
  
  context 'when related to config' do
    
    it 'should load configurations from a descritor.yml' do
      config = RSpecRunner::Config.new ['-f', @descriptor_path]
      config.should_not be_nil
      
      config.options.should_not be_nil
      
      config.options.project_path.should_not be_nil
      config.options.templates_path.should_not be_nil
      
      config.options.descriptor_path.should eql(@descriptor_path)
      config.options.execute.should eql('all')
    end
    
    it 'should accept the group name from args' do
      config = RSpecRunner::Config.new ['-f', @descriptor_path, '-g', 'group1']
      config.should_not be_nil
      
      config.options.should_not be_nil
      
      config.options.project_path.should_not be_nil
      config.options.templates_path.should_not be_nil
      
      config.options.execution_group_name.should eql('group1')
      config.options.execute.should eql('group1')
    end
    
  end
  
  context 'when related to app' do
    
    before :each do
      @config = RSpecRunner::Config.new ['-f', @descriptor_path, '-g', 'just_one']
    end
    
    it 'should initialize files and examples' do
      app = RSpecRunner::App.new(@config)
      app.should_not be_nil
      app.files.should_not be_nil
      app.examples.should_not be_nil
      app.open_in_browser?.should_not be_nil
    end
    
    it 'should extract files and examples on start' do
      app = RSpecRunner::App.new(@config)
      app.start!
      
      app.files.should_not be_empty
      app.examples.should_not be_empty
      app.execute.should eql('just_one')
    end
    
    it 'should extract just files' do
      @config = RSpecRunner::Config.new ['-f', @descriptor_path, '-g', 'group1']
      app = RSpecRunner::App.new(@config)
      app.start!
      
      app.files.should_not be_empty
      app.examples.should be_empty
      app.execute.should eql('group1')
    end
    
  end
  
  context 'when related to descriptor_generator' do
    before :each do
      @templates_path = 'templates/'
      @project_path = 'spec/resources/'
    end                                             
    
    it 'should initialize everything' do
      generator = RSpecRunner::Generator::DescriptorGenerator.new(@templates_path, @project_path)
      generator.instance_variable_get('@templates_path').should eql(@templates_path)
      generator.instance_variable_get('@project_path').should eql(@project_path)
      generator.instance_variable_get('@spec_path').should_not be_nil
      generator.instance_variable_get('@descriptor_template_path').should_not be_nil
      generator.instance_variable_get('@file_path').should_not be_nil
    end
    
    it 'should generate the file' do
      require 'fileutils'
      
      spec_path = File.expand_path(File.join(@project_path, 'spec'))
      descriptor_path = File.join(spec_path, 'descriptor.yml')
      
      FileUtils.rm_rf spec_path
      File.exist?(spec_path).should be_false
      
      generator = RSpecRunner::Generator::DescriptorGenerator.new(@templates_path, @project_path)
      generator.generate!
                                                                         
      # Generate the directory
      File.exist?(spec_path).should be_true
      File.exist?(descriptor_path).should be_true
      
      content = File.open(descriptor_path).read
      (content =~ /default: all/).should be_true
      (content =~ /open_in_browser: true/).should be_true
      
      FileUtils.rm_rf spec_path
    end
    
  end
  
end





































