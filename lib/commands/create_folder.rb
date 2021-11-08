module CommandsHelper
    module CreateFolder
        def self.get_folder_name(input)
            folder_name = input[14..(input.length-1)]
            return folder_name 
        end

        def self.create_persisted_folder(folder_name, current_path, path_metadata)
            Dir.chdir(current_path) do
                if (File.exist? (folder_name))  && (File.directory?(folder_name))  
                    puts "#{folder_name} already exists."
                else
                    Dir.mkdir folder_name 
                    Dir.chdir(path_metadata) do 
                        Dir.mkdir folder_name
                    end
                end
            end
        end
    end
end
