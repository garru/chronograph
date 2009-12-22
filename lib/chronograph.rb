require 'benchmark'
class Chronograph

  def self.measurements
    Thread.current[:_chronograph] ||= Hash.new{|h,k|h[k] = 0}
  end
  
  def self.push(type)
    Thread.current[:_chronograph_stack] ||= []
    Thread.current[:_chronograph_stack] << type
  end
  
  def self.pop
    Thread.current[:_chronograph_stack].pop
  end
  
  def self.measure(type, &block)
    push(type)
    measurements[Thread.current[:_chronograph_stack].join(":")] += Benchmark.realtime do
      block.call
    end
    pop
  end
  
  def self.reset
    Thread.current[:_chronograph] = Hash.new{|h,k|h[k] = 0}
  end
  
  def self.results
    Thread.current[:_chronograph]
  end

end