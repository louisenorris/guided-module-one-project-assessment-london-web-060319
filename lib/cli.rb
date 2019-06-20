require 'pry'
class CommandLineInterface

attr_reader :prompt, :font, :pastel
attr_accessor :current_user

  def initialize
    @prompt = TTY::Prompt.new
    @font = TTY::Font.new(:doom)
    @pastel = Pastel.new
    @user_id = nil
    @plant_id  = nil
  end

  def title
    puts pastel.green(font.write("Urban Jungle", letter_spacing: 2))
  end

  def greet
    puts pastel.green("Welcome to the Urban Jungle, the best source for indoor plants outside of your home!")
    user_input = prompt.select("Are you a registered User?", %w(Yes No))
      if user_input == "Yes"
        log_in
      elsif user_input == "No"
        register
      end
  end

  # def find_current_user(user_id)
  #   user_details = User.find_by(id: user_id)
  # end

  def print_user_details(user_id)
    user_details = User.find_by(id: user_id)
      puts pastel.green("Your details are as follows:")
      puts "User ID: #{user_details.id}"
      puts "First name: #{user_details.first_name}"
      puts "Second name: #{user_details.second_name}"
      puts "Email: #{user_details.email}"
      puts "Address 1: #{user_details.address1}"
      puts "Address 2: #{user_details.address2}"
      puts "City: #{user_details.city}"
      puts "Post code: #{user_details.post_code}"
      puts "Account balance: #{user_details.balance}"
  end

  def log_in
    puts pastel.green("Please enter your User ID:")
    @user_id = gets.chomp.to_i
      if User.find_by(id: @user_id) == nil
        puts pastel.green("Looks like you are not a Urban Jungle registered user, please register your details.")
        register
      else
        print_user_details(@user_id)
        menu
      end
  end

  def register
    puts pastel.green("To register please enter your details as prompted.")
      new_user = prompt.collect do
        key(:first_name).ask('First name?', required: true)
        key(:second_name).ask('Second name?', required: true)
        key(:email).ask('Email?', required: true)
        key(:address1).ask('First line address?', required: true)
        key(:address2).ask('Second line address?')
        key(:city).ask('City?', required: true)
        key(:post_code).ask('Post Code?', required: true)
      end
    user_saved_to_db = User.create(new_user)
    @user_id = user_saved_to_db.id
    puts pastel.green("New User registration complete, please note your ID number:")
    print_user_details(@user_id)
    puts "One moment please..."
    sleep(3)
    menu
  end

  def menu
    user_input = prompt.select("Please select one of the following options:", %w(account_balance search update delete_account exit))
     if user_input == "account_balance"
       update_balance
     elsif user_input == "search"
       search
      elsif user_input == "update"
        update
      elsif user_input == "delete_account"
        delete_account
      else user_input == "exit"
  		  anything_else
  		end
	 end

   # def find_user
   #   user_details = User.find_by(id: @user_id)
   # end
   #
   # def update_balance(user_balance)
   #   puts pastel.green("Please state the amount you would like to update your balance by:")
   #   user_input = gets.chomp.to_i
   #   update_by = (user_balance + user_input)
   #   user_details.update(balance: update_by)
   #   puts "One moment please..."
   #   sleep(3)
   #   puts "Your current balance is now #{user_details.balance}."
   # end


   def update_balance
     user_details = User.find_by(id: @user_id)
     user_balance = user_details.balance
     next_step = prompt.select("Your current balance is £#{user_details.balance}, would you like to update your balance?", %w(Yes No))
      if next_step == "Yes"
        puts pastel.green("Please state the amount you would like to update your balance by:")
        user_input = gets.chomp.to_i
        update_by = (user_balance + user_input)
        user_details.update(balance: update_by)
        puts "One moment please..."
        sleep(3)
        puts "Your current balance is now £#{user_details.balance}."
        menu
      else next_step == "No"
        puts "Ok, let's return to the menu."
        puts "One moment please..."
        sleep(3)
        menu
       end
   end

    def search
      user_input = prompt.select("How would you like to search for a plant?", ["search climate", "search cost", "search color", "return to menu"])
      if user_input == "search climate"
        search_climate
      elsif user_input == "search cost"
        search_cost
      elsif user_input == "search color"
        search_color
      else user_input == "return to menu"
        menu
     end
    end

    def would_you_like_to_purchase(plant_species)
      what_next = prompt.select("Would you like to purchase one of these plants?", %w(Yes No))
        if what_next == "Yes"
          choosen_plant = prompt.select("Please select your chosen plant:", [plant_species])
          purchase(choosen_plant)
          menu
        else what_next == "No"
          menu
        end
    end

    def search_climate
      user_input = prompt.select("Please select one of the following climate options which best represents a quality of your home environment:", ["humidity", "direct sunlight", "indirect light", "shade", "hot dry climate", "return to menu"])
        if user_input != "return to menu"
          plants_match = Plant.all.select{|plant| plant.preferences == user_input.to_s}
          plant_species = plants_match.map{|plant| plant.species }
          puts plant_species
          would_you_like_to_purchase(plant_species)
        else user_input == "return to menu"
          menu
        end
    end

    def search_cost
      puts pastel.green("We can provide plants to suit most budgets! Please enter your maximum budget to see all plants within your price range:")
      user_input = gets.chomp.to_i
      plants_in_budget = Plant.all.select{|plant| plant.price <= user_input}
      plant_species = plants_in_budget.map{|plant| plant.species }
      puts plant_species
      would_you_like_to_purchase(plant_species)
    end

    def search_color
      user_input = prompt.ask("Please enter your chose plant color:")
      Plant.find_by_color(user_input)
      menu
    end

    def purchase(choosen_plant)
      user_details = User.find_by(id: @user_id)
      user_balance = user_details.balance
      plant_details = Plant.find_by(species: choosen_plant)

    #  binding.pry
      plant_price = plant_details.price
    #  binding.pry
        if user_details.balance < plant_details.price
          puts "Looks like you do not have enough credit in your account to purchase this plant. Please return to the menu to credit your account."
        else
          puts pastel.green("Transaction in process...")
          basket = Plant.all.find_by(species: choosen_plant)
          checkout = basket.id
          Purchase.create(:date => Time.now.strftime("%F %T"), :user_id => @user_id, :plant_id => checkout)
          update_by = (user_details.balance - plant_details.price)
          user_details.update(balance: update_by)
          puts "One moment please..."
          sleep(3)
          puts pastel.green("Your new plant is purchased! Your new balance is £#{user_details.balance}")
          puts "One moment please..."
          sleep(3)
        end
    end

    def update
      next_step = prompt.select("Would you like to update your email address?", %w(Yes No))
      if next_step == "Yes"
        puts pastel.green("Please enter your new email address:")
        user_input = gets.chomp.to_s
        update_email = User.find_by(id: @user_id)
        update_email.update(email: user_input)
        puts "One moment please..."
        sleep(3)
        puts pastel.green("Your email address has been updated:")
        print_user_details(@user_id)
        puts "One moment please..."
        sleep(3)
        menu
      else next_step == "No"
       menu
      end
    end

    def delete_account
      question_delete = prompt.select("Are you sure you want to delete your Urban Jungle account?", %w(Yes No))
        if question_delete == "Yes"
          User.destroy (@user_id)
          puts pastel.green("Your account has been deleted, thank you for your custom.")
          exit_app
        else question_delete == "No"
          puts pastel.green("No worries, lets take you back to the main menu.")
          menu
        end
    end

      # all_purchases_for_a_user
      #return a plant
      #find all plants purchased by a user
    #   user_purchases = Purchase.all.find_by(user_id: @user_id)
    #   binding.pry
    #   purchase_list = (user_purchases.plant_id).species
    #
    #   plant_names = Plant.find_by(purchase_list).species
    #     binding.pry
    #     if user_purchases == nil
    #       puts "You have not purchased any plants. Return to the menu and select search to look for a plant which suits you!"
    #       sleep(3)
    #       menu
    #     elsif puts "Please see below a list of plants you have purchased."
    #       next_bit = prompt.select("Would you like to return a plant for a refund?", %w(Yes No))
    #         if what_next == "Yes"
    #           choosen_plant = prompt.select("Please select your a plant to return:", [plant_species])
    #           return_plant.destroy
    #           puts "This plant has been returned. Thank you."
    #           menu
    #         else what_next == "No"
    #           puts "No worries, lets take you back to the main menu."
    #           menu
    #         end
    #     end
    # end


    def anything_else
      user_input = prompt.select("Is there anything else we can help you with today?", %w(Yes No))
      if user_input == "Yes"
        menu
      else user_input == "No"
       exit_app
     end
    end

  def exit_app
  	puts pastel.green("Goodbye")
  end

end
