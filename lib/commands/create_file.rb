module CommandsHelper
    module CreateFile 
        def self.get_file(input)
            file_name = ""
            file_content = ""
            for i in 12..(input.length-1)                               #create_file file1 "content"
                if (input[i] == " ") 
                    file_name = input[12..i-1]
                    file_content = input[i+1+1..(input.length-1-1)]     # descuento los " "
                    break
                end     
            end   
            return [file_name, file_content]
        end

        def self.create_file(file_aux, path, current_user)
            metadata = CommandsHelper::MetadataFile.get_not_persisted_metadata(file_aux[0], file_aux[1], path, current_user) 
            return [file_aux[0], file_aux[1], metadata]
        end

        def self.create_persisted_file(file, current_path, path_metadata)
            file_name = file[0]
            file_content = file[1]
            file_content.to_s
            Dir.chdir(current_path) do    
                if (File.exist? ("#{file_name}.txt")) && (File.file?("#{file_name}.txt")) 
                    puts "#{file_name}.txt already exists."
                else
                    new_file = File.open "#{file_name}.txt", "w"  
                    new_file.write(file_content)
                    new_file.close
                    metadata = CommandsHelper::MetadataFile.get_persisted_metadata("#{file_name}.txt", current_path).join("\n")
                    Dir.chdir(path_metadata) do
                        new_file_metadata = File.open "#{file_name}_metadata.txt", "w"
                        new_file_metadata.write(metadata) 
                        new_file_metadata.close
                    end
                    puts "New #{file_name}.txt created"
                end
            end
        end
    end
end

#  Para ver el actual path
# File. expand_path(File. dirname(__FILE__))
