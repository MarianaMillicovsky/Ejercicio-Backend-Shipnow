module CommandsHelper
    module ShowFile
        def self.get_file_name(input)    # 'show file1' 
            file_name = input[5..(input.length-1)]
            return file_name
        end

        def self.show_file(file_name, path)
            Dir.chdir(path) do
                if (File.exist? (file_name)) && (File.file?(file_name)) 
                  puts ' '
                  File.open(file_name, "r") {|f|
                  puts f.read
                  }
                  puts ' '
                else 
                  puts 'File not found.'
                end
            end
        end
    end
end
