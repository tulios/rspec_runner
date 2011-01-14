module RSpecRunner
  module Opener
    class << self

      def open file_path
        case RbConfig::CONFIG["host_os"]
        when /darwin/i
          darwin(file_path)
        when /msdos|mswin|djgpp|mingw/i
          windows(file_path)
        when /linux/i
          linux(file_path)
        else
          raise NotImplemented.new "An opener for #{RbConfig::CONFIG["host_os"]} is not implemented yet!"
        end
      end
    
      private
    
      def darwin file_path
        `open #{file_path}`
      end
    
      def windows file_path
        raise NotImplemented.new "An opener for windows(#{RbConfig::CONFIG["host_os"]}) is not implemented yet!"
      end
    
      def linux file_path
        raise NotImplemented.new "An opener for linux(#{RbConfig::CONFIG["host_os"]}) is not implemented yet!"
      end
      
    end
  end
end