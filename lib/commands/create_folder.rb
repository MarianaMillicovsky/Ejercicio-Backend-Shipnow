module CommandsHelper
    module CreateFolder
        def self.get_folder_name(input)
            folder_name = input[14..(input.length-1)]
            return folder_name 
        end
    end
end
