# require 'rainbow'

module RSpecRunner
  class OutputListener
      
    def initialize
      @stop = false
    end
    
    def stop
      @stop = true
    end
    
    def color css_class
      if css_class =~ /passed/ then :green
      elsif css_class =~ /failed/ then :red
      elsif css_class =~ /not_implemented/ then :yellow
      elsif css_class =~ /pending_fixed/ then :yellow
      end
    end
    
    def start stdout
      file = File.open(stdout.path)
      file.sync = true
      
      pos = file.pos
      Thread.new do
        until @stop
          content = file.read
          new_pos = file.pos
          
          # Detect if the file changes
          if new_pos > pos
            # DD
            content.scan(/<dd\s+class="([^"]*)"\s*>(.*)<\/dd>/).each do |dd|
            
              # SPAN                      
              css_class, span = dd[0], dd[1]
              span.scan(/<span [^>]*>([^<\/]*)<\/span>/).each {|spec| puts spec.first.color(color(css_class))}
              
            end
          end
        end
      end
    end
      
  end
end