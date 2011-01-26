module RSpecRunner
  module Formatter
    class TextAndHtmlFormatter < Spec::Runner::Formatter::HtmlFormatter
      
      def initialize(options, where)
        super
        @last_nested_descriptions = []
      end
      
      def start(example_count)
        puts "Running #{example_count} #{(example_count == 1) ? 'example' : 'examples'}:"
        super
      end
      
      def example_group_started(example_group)
        super
        
        example_group.nested_descriptions.each_with_index do |nested_description, index|
          unless example_group.nested_descriptions[0..index] == @last_nested_descriptions[0..index]
            puts "#{ident*index}#{nested_description}"
          end
        end
        
        @last_nested_descriptions = example_group.nested_descriptions
      end
      
      def example_passed(example)
        puts "#{current_ident}#{example.description}".color(:green)
        super
      end
      
      def example_failed(example, counter, failure)   
        puts "#{current_ident}#{example.description} (FAILED - #{counter})".color(:red)
        super
      end
      
      def dump_failure(counter, failure)
        puts "\n#{counter.to_s})".color(:red)
        puts "#{failure.header}\n#{failure.exception.message}:\n".color(:red)
        puts format_backtrace(failure.exception.backtrace)
        puts ""
      end
      
      def example_pending(example, message, deprecated_pending_location = nil)
        puts "#{current_ident}#{example.description}".color(:yellow)
        super
      end
      
      def dump_summary(duration, example_count, failure_count, pending_count)
        puts "\nFinished in #{duration} seconds"
        
        summary = "#{example_count} example#{'s' unless example_count == 1}"
        summary << ", #{failure_count} failure#{'s' unless failure_count == 1}"
        summary << ", #{pending_count} pending" if pending_count > 0
        puts summary
        super
      end
      
      private
      def format_backtrace backtrace
        return "" if backtrace.nil?
        backtrace.map { |line| backtrace_line(line) }.join("\n")
      end
      
      def current_ident
        ident*@last_nested_descriptions.length
      end
      
      def ident
        ' '*2
      end
      
    end
  end
end