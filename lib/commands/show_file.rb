module CommandsHelper
    module ShowFile
        def self.get_file_name(input)    # 'show file1' 
            file_name = input[5..(input.length-1)]
            return file_name
        end
    end
end
