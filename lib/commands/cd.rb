module CommandsHelper
    module CdCommand 
        def self.cd_enter_folder(input)   
            folder_name = input[3..(input.length-1)]  #  cd folder
            return folder_name
        end
    end
end
