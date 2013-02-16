require "prepend_code/version"
begin
  require "pry"
rescue LoadError
end

module PrependCode
  module Application
    def self.run!(*arguments)
      dir_base = './app'
      ext = '.rb'
      code = '# coding: utf-8'
      opts = OptionParser.new
      opts.on("-d target directory. default: ./app."){|v| dir_base = v }
      opts.on("-e target file extension. default: .rb"){|v| ext = v }
      opts.on("-t prepend context. default: # coding: utf-8"){|v| code = v }
      opts.parse!(arguments)

      file_paths = find_file_paths(dir_base, ext)

      count = 0
      file_paths.each do |file_path|
        result = prepend_on_file!(file_path, code)
        count += 1 if result
      end
      puts sprintf('%s files has been matched.', file_paths.count)
      puts sprintf('%s files has been saved.', count)
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
    
    def self.prepend_on_file!(file_path, code)
      f = File.open(file_path, "r+")
      lines = f.readlines
      f.close
      
      return false if lines && lines[0] == code + "\n"
      lines = [sprintf('%s%s', code, "\n")] + lines
      output = File.new(file_path, "w")
      lines.each { |line| output.write line }
      output.close
      return true
    end
  end
end
