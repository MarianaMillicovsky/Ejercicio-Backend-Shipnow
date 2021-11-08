class NewSessionPersisted                             
    attr_accessor :absolute_path_home, :current_path, :path_metadata
    def initialize
      @absolute_path_home = Dir.pwd
      @current_path = (@absolute_path_home + '/home') 
      @path_metadata = (@absolute_path_home + '/metadata')
    end

    def first_folder
      Dir.chdir(@absolute_path_home) do
        Dir.mkdir ('home') if !(File.exist? ("home"))
        Dir.mkdir ('metadata') if !(File.exist? ("metadata"))
      end
    end
    
    def add_new_file(input)                                            
      file = CommandsHelper::CreateFile.get_file(input)
      CommandsHelper::CreateFile.create_persisted_file(file, current_path, path_metadata)
    end 
  
    def add_new_folder(input)                                                                                   
      folder_name = CommandsHelper::CreateFolder.get_folder_name(input)
      CommandsHelper::CreateFolder.create_persisted_folder(folder_name, current_path, path_metadata)
    end
  
    def ls_command 
      Dir.chdir(current_path) do
        if Dir.children(current_path).length > 0 
          Dir.children(current_path).each {|x| print (x + '   ') }
          puts ' '
        else 
          puts 'No files/folders here yet.'
        end
      end
    end
  
    def cd_enter_command(input)                                                   
      folder_name = CommandsHelper::CdCommand.cd_enter_folder(input)
      Dir.chdir(current_path) do
        if (File.exist? (folder_name)) && (folder_name != ('.' || '..')) && (File.directory?(folder_name)) 
          @current_path += "/#{folder_name}"
          @path_metadata += "/#{folder_name}"
        else  
          puts 'Folder not found.'
        end
      end
    end
  
    def cd_back_command 
      aux = CommandsHelper::CdCommand.get_before_path(current_path, absolute_path_home, path_metadata)
      @current_path = aux[0] if aux[0] != ''
      @path_metadata = aux[1] if aux[1] != ''      
    end
  
    def destroy_file_folder(input)                                                                  
      file_folder_name = CommandsHelper::DeleteFileFolder.get_file_folder_name(input)
      CommandsHelper::DeleteFileFolder.destroy_persisted_file_folder(file_folder_name, current_path, path_metadata)
    end 
  
    def metadata(input) 
      file_name = CommandsHelper::MetadataFile.get_file_name(input)
      CommandsHelper::ShowFile.show_file(file_name, path_metadata)
    end 
  
    def whereami        
      puts @current_path                                                                       
    end
  
    def show_file(input)                                                                 
      file_name = CommandsHelper::ShowFile.get_file_name(input)
      CommandsHelper::ShowFile.show_file(file_name, current_path)
    end

end
   
# para la metadata: se crea una carpeta paralela a home llamada 'metadata'.
