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
                @data_users[@new_name] = @new_password
                puts "New user #{@new_name} created."
                break 
            end
        end
    end

    def create_user_command(input) 
        for i in 12..(input.length-1)                               #create_user username password
            if (input[i] == " ") 
                @new_name = input[12..i-1]
                @new_password = input[i+1..(input.length-1)]     # descuento los " "
                break
            end     
        end
        #puts @new_name 
        #puts @new_password
        if @data_users.key?(@new_name)
            puts "=> That username already exists. Try again." 
        elsif @new_name.length < 2
            puts "=> Invalid username"
        else
            @data_users[@new_name] = @new_password
            puts "New user #{@new_name} created."
        end
    end

    def login_user_command(input)  
        for i in 6..(input.length-1)                               #login username password
            if (input[i] == " ") 
                @user_name = input[6..i-1]
                @user_password = input[i+1..(input.length-1)]     # descuento los " "
                break
            end     
        end
        #puts @user_name 
        #puts @user_password
        if @data_users.key?(@user_name) && (@data_users[@user_name.to_s] == @user_password.to_s)
            @current_user = @user_name
            return "passed"
        else
            puts "Sorry, try again. " 
        end     
    end

    def whoami
        puts "Current user: #{@current_user}" 
    end

    def check(persistence)         ## Funcion en caso de pedir registro al inicio
        if !persistence
            loop do 
                puts "  => Please type your username to sign in. \n  => To sign up, press enter."
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
