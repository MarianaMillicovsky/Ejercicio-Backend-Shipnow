class Consola 
    attr_accessor :line_length, :new_session

    def initialize
        @line_length = 1
        @new_session
    end

    input = STDIN.gets.chomp
    input.strip! 

    if ARGF.argv == ['-persisted', 'file']
        @new_session = NewSessionPersisted.new()
      else
        @new_session = NewSession.new()
    end

    case input
        when (input === 'exit') || (input === 'quit') 
            break
        when /create_file ([a-zA-Z0-9_.])+ (('(.{0,})')||("(.{0,})"))$/      #COMMAND: create_file file1 'c1'
            @new_session.create_file(file_name,file_content)
        when /^show ([a-zA-Z0-9_. ]+$)$/                                     #COMMAND: show file1
            @new_session.show_file(input[5..(input.length-1)])
        when /^metadata (.+$)$/                                              #COMMAND: metadata file1  
            @new_session.metadata(file_name) 
        when /^create_folder ([a-zA-Z0-9_.]+$)$/                             #COMMAND: create_folder folder1
            @new_session.create_folder(folder_name)
        when /^cd (\.\.$)/                                                   #COMMAND: cd ..
            @new_session.cd_back
        when /^cd (.+$)$/                                                    #COMMAND: cd folder1
            @new_session.cd_enter(folder_name)
        when /^destroy ([a-zA-Z0-9_.]+$)$/                                   #COMMAND: destroy file1/folder1   
            @new_session.destroy(file_folder_name) 
        when /^ls$/                                                          #COMMAND: ls
            @new_session.ls
        when /^whereami$/                                                    #COMMAND: whereami
            @new_session.whereami
    end

end
  