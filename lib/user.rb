class User
    attr_accessor :user_name, :user_password, :current_user, :new_name, :new_password
    def initialize
      @data_users = {}  
      @user_name 
      @user_password
      @current_user = ""
      @new_name = ""
      @new_password = ""
    end

    def create_database 
    end

    def create_user
        loop do 
            puts "=> Please type your new username" 
            @new_name = gets.chomp
            @new_name.strip!                 # devuelve un nil si no se modifica el string
            if @data_users.key?(@new_name)
                puts "=> That username already exists. Try again." 
            elsif @new_name.length < 2
                puts "=> Invalid username"
            else
                puts "=> Please type your new password" 
                @new_password = gets.chomp() 
                @new_password.strip!
                @data_users[@new_name] = @new_password
                puts "New user #{@new_name} created."
                break 
            end
        end
    end

    def create_persisted_user 
    end

    def login_persisted_user   
    end

    def whoami
        puts "Current user: #{@current_user}" 
    end

    def check(persistence)
        if !persistence
            loop do 
                puts "  => Please type your username to sign up. \n  => To sign in, press enter."
                input_aux = STDIN.gets.chomp
                if (input_aux === 'exit') || (input_aux === 'quit') 
                    break
                elsif input_aux == "" 
                    create_user()
                else
                    3.times do
                        user_name = input_aux
                        puts "=> Please type your password"
                        password = gets.chomp  
                        if @data_users.key?(user_name) && (@data_users[user_name.to_s] == password.to_s)
                            @current_user = user_name
                            return "passed"
                            break 
                        else
                            puts "Sorry, try again. " 
                        end  
                    end
                end
            end
        end 
    end

end

# Estructura:
# data = { user1_name => user1_password, user2_name => user2_password }
