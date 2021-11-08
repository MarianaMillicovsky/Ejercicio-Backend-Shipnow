class Repl 
    REPL_PROMPT = 'FFM_REPL > '                  
  
   attr_accessor :line_length, :new_session
    def initialize
      @line_length = 1
      @new_session = NewSession.new()
    end
  
    def run
      before_loop
      in_loop
      after_loop
    end
  
    private
    def before_loop
      print "Welcome to Files&Folders Manager console, for help, please type '-help'\nType exit/quit to end the session.\n"
    end

    def in_loop
      loop do
        #break unless (check == "passed") || (persistence)  # aun no se hizo el checkeo  de usuario con persistencia
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
              @new_session.add_new_file(input) 
            when /^show ([a-zA-Z0-9_. ]+$)$/                                     #COMMAND: show file1
              @new_session.show_file(input) 
            when /^metadata (.+$)$/                                              #COMMAND: metadata file1   
              @new_session.metadata(input)    
            when /^create_folder ([a-zA-Z0-9_.]+$)$/                             #COMMAND: create_folder folder1
              @new_session.add_new_folder(input) 
            when /^cd (\.\.$)/                                                   #COMMAND: cd ..
              @new_session.cd_back_command 
            when /^cd (.+$)$/                                                    #COMMAND: cd folder1
              @new_session.cd_enter_command(input)  
            when /^destroy ([a-zA-Z0-9_.]+$)$/                                   #COMMAND: destroy file1/folder1    
              @new_session.destroy_file_folder(input) 
            when /^ls$/                                                          #COMMAND: ls
              @new_session.ls_command 
            when /^whereami$/                                                    #COMMAND: whereami
              @new_session.whereami 
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
     