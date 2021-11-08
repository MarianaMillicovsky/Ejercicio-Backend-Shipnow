module CommandsHelper
    module CdCommand 
        def self.cd_enter_folder(input)   
            folder_name = input[3..(input.length-1)]  #  cd folder
            return folder_name
        end

        def self.get_before_path(current_path, absolute_path_home, path_metadata)
            aux_abs = absolute_path_home
            aux_abs = aux_abs.split('/')
            aux = current_path
            aux = aux.split('/')
            aux_metadata = path_metadata 
            aux_metadata = aux_metadata.split('/')
            if aux.length > (aux_abs.length + 1)         # me fijo si estoy en una carpeta 'hija' de 'home'
                aux.pop 
                aux = aux.join('/') 
                aux_metadata.pop
                aux_metadata = aux_metadata.join('/') 

                return [aux, aux_metadata]
            else 
                return ['','']
            end
        end
    end
end
