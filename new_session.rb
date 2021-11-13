class NewSession 
    attr_accessor :file_id, :path

    def initialize 
        @file_id = 0 
        @path
    end

    def self.create_file(file_name, file_content) 
        file_id += 1
        file_name = File.new(file_name: file_name, file_content: file_content, file_id: file_id) 
        metadata_name = "#{id}_metadata"  
        metadata_name = Metadata.new(file_name, path)     
    end

    def self.create_folder 
        folder_name = Folder.new(folder_name: folder_name)
    end

    def self.show_file
        File.all. 
    end

    def self.destroy_file 
    end

    def self.ls 
    end 
    
    def self.cd_enter 
    end 

    def self.cd_back 
    end

    def self.whereami 
    end

end