require 'rspec_runner'

describe RSpecRunner do 
  
  it 'should run a single test' do
    RSpecRunner.run 'test'
  end
  
end