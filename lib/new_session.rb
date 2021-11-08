class NewSession  
  attr_accessor :data, :actual_folder, :current_path, :data_file, :file_id
  def initialize
    @data = { "home" => {} }        #Hash
    @actual_folder= @data['home']   #Hash  
    @current_path = ['home']        #Array
    @data_file = {}                 #Hash 
    @file_id = 0                    
  end
  
  def add_new_file(input, current_user)   
    path = Array.new(@current_path)
    file_aux = CommandsHelper::CreateFile.get_file(input) # gets [name, content]
    file = CommandsHelper::CreateFile.create_file(file_aux, path, current_user) # gets [name,content,metadata]
    if (@actual_folder.has_key?(file[0])) && (@actual_folder[file[0]].class == String)
      puts "#{file[0]} already exists."
    else
      @file_id += 1
      data.dig(*(@current_path))[file[0]] = @file_id.to_s      # agrego el                    
      data_file[@file_id.to_s] = file                          # nuevo file
    end  
  end 

  def add_new_folder(input)                                                   
    folder_name = CommandsHelper::CreateFolder.get_folder_name(input)
    if (@actual_folder.has_key?(folder_name)) && (@actual_folder[folder_name].class == Hash)
      puts "#{folder_name} already exists." 
    else
      data.dig(*(@current_path))[folder_name] = {}            # agrego el nuevo folder 
    end
  end

  def ls_command             
    if @actual_folder.length == 0 
      puts 'No files/folders here yet.'
    else
      @actual_folder.each_key {|key| print (key + '   ') }
      puts ' ' 
    end
  end

  def cd_enter_command(input)                                                  
    folder_name = CommandsHelper::CdCommand.cd_enter_folder(input)
    if (@actual_folder.has_key?(folder_name)) && (@actual_folder[folder_name].class == Hash)
      @current_path.push(folder_name)                        
      @actual_folder = @data.dig(*(@current_path))
    else 
      puts 'Folder not found.'
    end
  end

  def cd_back_command                                                    
    if @current_path.size > 1
      @current_path.pop 
      @actual_folder = @data.dig(*(@current_path))
    end
  end

  def destroy_file_folder(input)                                                            
    file_folder_name = CommandsHelper::DeleteFileFolder.get_file_folder_name(input)
    if (@actual_folder.has_key?(file_folder_name)) 
      data.dig(*(@current_path)).delete(file_folder_name)
      data_file.delete(file_folder_name) if (@actual_folder[file_folder_name].class == String)
      @actual_folder = @data.dig(*(@current_path))
      print file_folder_name
      puts ' succesfully deleted.'
    else  
      puts 'File/Folder not found.' 
    end
  end 

  def metadata(input) 
    file_name = input[9..(input.length-1)]
    if (@actual_folder.has_key?(file_name)) && (@actual_folder[file_name].class == String)
      id = actual_folder[file_name]
      puts @data_file[id][2]
    else 
     puts 'File not found.' 
    end    
  end 

  def whereami                                                                                
    aux = Array.new(@current_path)   
    aux = aux.map! {|x| x + "/" }   
    aux = aux.join                   #"home/b/c/d/"
    puts aux
  end

  def show_file(input)                                                                 
    file_name = CommandsHelper::ShowFile.get_file_name(input)
    if (@actual_folder.has_key?(file_name)) && (@actual_folder[file_name].class == String)
      id = @actual_folder[file_name]
      puts ''
      puts @data_file[id][1]
      puts ''
    else 
     puts 'File not found.' 
    end
  end
end

# Estructura:
# data = { folder =>  { file1 => file1_id,    file2 => file2_id } }
# data_file = { file1_id => [file1_name, file1_content, metadata1],    
#               file2_id => [file2_name, file2_content, metadata2]}
