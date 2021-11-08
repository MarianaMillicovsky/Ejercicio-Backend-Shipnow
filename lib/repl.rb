class Repl 
    REPL_PROMPT = 'FFM_REPL > '                  
  
   attr_accessor :line_length, :persistence, :new_session, :new_session_persisted, :check
    def initialize
      @line_length = 1
      @new_session = NewSession.new()
      @new_session_persisted = NewSessionPersisted.new()
      @persistence = false
      @user = User.new()
      @check = false #parameter to check if user is logged
    end
  
    def run
      before_loop
      in_loop
      after_loop
    end
  
    private
    def before_loop
      if ARGF.argv == ['-persisted', 'file']
        @persistence = true
      else
        @persistence = false
      end
      print "Welcome to Files&Folders Manager console, for help, please type '-help'\nType exit/quit to end the session.\n"
      @check = @user.check(persistence)
    end

    def in_loop
      @new_session_persisted.first_folder if @persistence# && (check == "passed")   -aun no se hizo el checkeo de usuarios con persistencia en disco-
      loop do
        break unless (check == "passed") || (persistence)  # aun no se hizo el checkeo  de usuario con persistencia
        print "[#{@line_length}] #{REPL_PROMPT}"

        #input = Readline.readline("> ", true)   #using Readline -third-party library-
        input = STDIN.gets.chomp
        input.strip!  
  
        if (input === 'exit') || (input === 'quit')            
          break
        elsif (input == '-help')
          File.open("help.txt", "r") {|f|
                  puts f.read
                  }
                  puts ' '
        else
          begin
            case input
            when /create_file ([a-zA-Z0-9_.])+ (('(.{0,})')||("(.{0,})"))$/      #COMMAND: create_file file1 'c1'
              current_user = @user.current_user
              @new_session.add_new_file(input, current_user) if !persistence
              @new_session_persisted.add_new_file(input) if persistence
            when /^show ([a-zA-Z0-9_. ]+$)$/                                     #COMMAND: show file1
              @new_session.show_file(input) if !persistence
              @new_session_persisted.show_file(input) if persistence
            when /^metadata (.+$)$/                                              #COMMAND: metadata file1   
              @new_session.metadata(input) if !persistence   
              @new_session_persisted.metadata(input) if persistence   
            when /^create_folder ([a-zA-Z0-9_.]+$)$/                             #COMMAND: create_folder folder1
              @new_session.add_new_folder(input) if !persistence
              @new_session_persisted.add_new_folder(input) if persistence
            when /^cd (\.\.$)/                                                   #COMMAND: cd ..
              @new_session.cd_back_command if !persistence
              @new_session_persisted.cd_back_command if persistence
            when /^cd (.+$)$/                                                    #COMMAND: cd folder1
              @new_session.cd_enter_command(input) if !persistence 
              @new_session_persisted.cd_enter_command(input) if persistence 
            when /^destroy ([a-zA-Z0-9_.]+$)$/                                   #COMMAND: destroy file1/folder1    
              @new_session.destroy_file_folder(input) if !persistence
              @new_session_persisted.destroy_file_folder(input) if persistence
            when /^ls$/                                                          #COMMAND: ls
              @new_session.ls_command if !persistence
              @new_session_persisted.ls_command if persistence
            when /^whereami$/                                                    #COMMAND: whereami
              @new_session.whereami if !persistence
              @new_session_persisted.whereami if persistence
            when /^whoami$/
              @user.whoami
            else
              eval(input)  
            end
        rescue SyntaxError => e
          puts "\e[31m#{e.class}:\e[0m syntax error, near: #{input} "  
        rescue StandardError => e
          puts "\e[31m#{e.class}\e[0m "
        end
        end
        @line_length += 1
      end
    end

    def after_loop
      puts 'Bye'
    end
  
  end
     