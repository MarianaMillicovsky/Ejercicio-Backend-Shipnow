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

        def self.create_file(file_aux, path)
            metadata = CommandsHelper::MetadataFile.get_not_persisted_metadata(file_aux[0], file_aux[1], path) 
            return [file_aux[0], file_aux[1], metadata]
        end
    end
end

#  Para ver el actual path
# File. expand_path(File. dirname(__FILE__))
