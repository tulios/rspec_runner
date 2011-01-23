module RSpecRunner
  module Generator
    class DescriptorGenerator
      
      def initialize templates_path, project_path
        @templates_path = templates_path
        @project_path = project_path
        @spec_path = File.join(@project_path, 'spec')
        @descriptor_template_path = File.join(@templates_path, "descriptor.yml.erb")
        @file_path = File.join(@project_path, "spec", "descriptor.yml")
      end
      
      def generate!
        create_spec_dir
        if File.exist?(@file_path)
          puts 'you already have a descriptor.yml'
          return
        end
        
        files_binding = [] + collect_directories + collect_files
        template = ERB.new File.new(@descriptor_template_path).read, nil, '<>'
        
        file = File.open(@file_path, 'w')
        file.write(template.result(binding))
        file.flush
        file.close
        
        puts "Generated #{file.path}"
      end
      
      private
      def create_spec_dir
        Dir.mkdir(@spec_path) unless File.exist?(@spec_path)
      end
      
      def collect_directories
        dirs = Dir.open(@spec_path).entries.select {|e| e =~ /^[^\.]/}.select {|e| File.directory?(File.join(@spec_path, e))}
        dirs.map {|dir| "spec/#{dir}/*_spec.rb"}
      end
      
      def collect_files
        Dir.open(@spec_path).entries.select {|e| e =~ /_spec\.rb$/}.map {|f| "spec/#{f}"}
      end
      
    end
  end
end