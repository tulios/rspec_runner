require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSpecRunner do 
                                 
  it "should have the method run" do
    RSpecRunner.methods.member?("run").should be_true
  end                            
  
  it 'should run the test file pointed' do
    stdout = RSpecRunner.run_file File.expand_path(File.dirname(__FILE__) + '/../resources/example1_spec.rb')
    stdout.should_not be_nil
  end
  
  it 'should run a list of tests' do
    files = []
    files << File.expand_path(File.dirname(__FILE__) + '/../resources/example1_spec.rb')
    files << File.expand_path(File.dirname(__FILE__) + '/../resources/example2_spec.rb')
    
    stdout = RSpecRunner.run_files files
    stdout.should_not be_nil
  end
  
end