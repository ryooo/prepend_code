require "prepend_code/version"
require "readline"
begin
  require "pry"
rescue LoadError
end

module PrependCode
  module Application
    def self.exit_with_usage
      puts @opts.to_s
      return 0
    end
    
    def self.run!(*arguments)
      ext = '.rb'
      banner = "Usage: prepend_code target_directory context [options]"
      @opts = OptionParser.new(banner)
      @opts.on("-e [extension]", "target file extension. (default: .rb)"){|v| ext = v }
      @opts.parse!(arguments)
      dir_base = arguments[0]
      context = arguments[1]
      return self.exit_with_usage if context.nil?
      return self.exit_with_usage if dir_base.nil?

      file_paths = find_file_paths(dir_base, ext)
      loop do
        messages = []
        messages << sprintf("Target directory is %s", dir_base)
        messages << sprintf("Context is %s", context)
        messages << sprintf("Target file count is %s. Are yor sure?[Y/n]", file_paths.count)
        input = Readline.readline(messages.join("\n"))
        break if input == 'Y'
        return 0 if input == 'n'
      end

      count = 0
      file_paths.each do |file_path|
        result = prepend_on_file!(file_path, context)
        count += 1 if result
      end
      puts sprintf('%s files has been matched.', file_paths.count)
      puts sprintf('%s files has been updated.', count)
      return 1
    end
    
    def self.find_file_paths(dir_name, ext)
      ret = []
      dirs = Dir.glob(dir_name)
      dirs.each {|d|
        next unless FileTest.directory?(d)
        
        sub_dirs = Dir.glob("#{d}/**")
        sub_dirs.each {|d|
          if FileTest.directory?(d)
            ret += find_file_paths(d, ext)
          elsif FileTest.file?(d)
            if d =~ /^*#{ext}$/
              ret << d
            end
          end
        }
      }
      return ret
    end
    
    def self.prepend_on_file!(file_path, context)
      f = File.open(file_path, "r+")
      lines = f.readlines
      f.close
      
      return false if lines && lines[0] == context + "\n"
      lines = [sprintf('%s%s', context, "\n")] + lines
      output = File.new(file_path, "w")
      lines.each { |line| output.write line }
      output.close
      return true
    end
  end
end
