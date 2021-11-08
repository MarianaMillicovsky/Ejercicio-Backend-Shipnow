module CommandsHelper
    module DeleteFileFolder
        def self.get_file_folder_name(input) 
            file_folder_name = input[8..(input.length-1)]    # 'destroy filefoler1'
            return file_folder_name
        end
    end
end
