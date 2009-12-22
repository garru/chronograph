require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Chronograph" do
  before :each do
    Chronograph.reset
  end
  
  it "should measure different types" do
    Chronograph.measure("database") do 
      sleep(1)
    end
  
    Chronograph.measure("rendering") do 
      sleep(0.1)
    end
    
    puts Chronograph.results.inspect
  end
  
  it "should handle nested measurements" do
    Chronograph.measure("database") do 
      Chronograph.measure("rendering") do 
        sleep(0.1)
      end
      sleep(1)    
    end
    
    puts Chronograph.results.inspect
  end
end
