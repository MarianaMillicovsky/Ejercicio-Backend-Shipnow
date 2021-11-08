module CommandsHelper
    module DeleteFileFolder
        def self.get_file_folder_name(input) 
            file_folder_name = input[8..(input.length-1)]    # 'destroy filefoler1'
            return file_folder_name
        end

        def self.destroy_persisted_file_folder(file_folder_name, current_path, path_metadata)
            aux_file = "#{file_folder_name[0...-4]}_metadata.txt"  # file_name.txt => file_name_metadata.txt
            Dir.chdir(current_path) do
                if (File.exist? (file_folder_name)) && (File.file?((file_folder_name)))
                    File.delete(file_folder_name)
                    Dir.chdir(path_metadata) do 
                        File.delete(aux_file)
                    end
                    puts "#{file_folder_name}  succesfully deleted."
                elsif (File.exist? (file_folder_name)) && (File.directory?(file_folder_name))
                    if  Dir.empty?(file_folder_name)
                        Dir.delete(file_folder_name)
                        Dir.chdir(path_metadata) do 
                            Dir.delete(file_folder_name)
                        end 
                        puts "#{file_folder_name}  succesfully deleted."
                    else
                        puts "Cannot delete #{file_folder_name}: not empty!"      
                    end
                else
                    puts 'File/Folder not found.'
                end
            end 
        end
    end
end
