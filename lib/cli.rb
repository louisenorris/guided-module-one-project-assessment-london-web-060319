require 'pry'
class CommandLineInterface

attr_reader :prompt, :font, :pastel
attr_accessor :current_user
#current user set to nil

def initialize
  @prompt = TTY::Prompt.new
  @font = TTY::Font.new(:doom)
  @pastel = Pastel.new
  @user_id = nil
end

  def title
    puts pastel.green(font.write("Urban Jungle", letter_spacing: 2))
  end

  def greet
    puts 'Welcome to the Urban Jungle, the best source for indoor plants outside of your home!'
    user_input = prompt.select("Are you a registered User?", %w(Yes No))
    if user_input == "Yes"
      log_in #make method
   elsif user_input == "No"
     register
   end
  end

# ADD LATER IF TIME - CHECKS IF USER ID EXISTS AND IF NOT SENDS TO register
#user check meth
#   validation - if !new_var
#     register
#   else


  def print_user_details(user_id)
    user_details = User.find_by(id: user_id)
    puts "Your details are as follows:"
    puts "User ID: #{user_details.id}"
    puts "First name: #{user_details.first_name}"
    puts "Second name: #{user_details.second_name}"
    puts "Email: #{user_details.email}"
    puts "Address 1: #{user_details.address1}"
    puts "Address 2: #{user_details.address2}"
    puts "City: #{user_details.city}"
    puts "Post code: #{user_details.post_code}"
  end

  def log_in
    puts 'Please enter your User ID;'
    @user_id = gets.chomp.to_i
    print_user_details(@user_id)
    sleep(3)
    menu
  end

  def register
  puts "To register please enter your details as prompted."
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
#binding.pry
  puts "New User registration complete, please note your ID number:"
  print_user_details(@user_id)
  #return details or at least user id for info
  #  puts User.all.last
  # puts current_user
  #binding.binding.pry
  sleep(3)
  menu
  end

  def menu
    user_input = prompt.select("Please select one of the following options:", %w(search refund update exit))
       if user_input == "search"
         search
      elsif user_input == "refund"
        refund #add this method
      elsif user_input == "update"
        update #add this method
      else user_input == "exit"
  		  anything_else
  		end
	  end


    def search
      user_input = prompt.select("How would you like to search for a plant?", ["search climate", "search cost", "return to menu"])
      if user_input == "search climate"
        search_climate
      elsif user_input == "search cost"
       search_cost
     else user_input == "return to menu"
       menu
     end
    end

    def search_climate
      user_input = prompt.select("Please select one of the following climate options which best represents a quality of your home environment:", ["humidity", "direct sunlight", "indirect light", "shade", "hot dry climate", "return to menu"])
      if user_input != "return to menu"
        plants_match = Plant.all.select{|plant| plant.preferences == user_input.to_s}

        plant_species = plants_match.map{|plant| plant.species }
        puts plant_species

        what_next = prompt.select("Would you like to purchase one of these plants?", %w(Yes No))
        if what_next == "Yes"
          choosen_plant = prompt.select("Please select your chosen plant:", [plant_species])
          purchase(choosen_plant)
          menu
        else what_next == "No"
         menu
        end
      else user_input == "return to menu"
       menu
      end
    end

    def search_cost
      puts "We can provide plants to suit most budgets! Please enter your maximum budget to see all plants within your price range:"
      user_input = gets.chomp.to_i
      plants_in_budget = Plant.all.select{|plant| plant.price <= user_input}

      plant_species = plants_in_budget.map{|plant| plant.species }

      puts plant_species

      what_next = prompt.select("Would you like to purchase one of these plants?", %w(Yes No))
      if what_next == "Yes"
        choosen_plant = prompt.select("Please select your chosen plant:", [plant_species])
        purchase(choosen_plant)
        menu
      else what_next == "No"
       menu
      end
    # else user_input == "return to menu"
    #  menu
    # end
  end

    def purchase(choosen_plant)
      #puts "Please enter your User ID number:"
      #@current_user = gets.chomp.to_i
      puts "Transaction in process..."
      basket = Plant.all.find_by(species: choosen_plant)
      checkout = basket.id
      #binding.pry
      Purchase.create(:date => Time.now.strftime("%F %T"), :user_id => @user_id, :plant_id => checkout)
      sleep(3)
      puts "Your new plant is purchased!"
      sleep(3)
      menu
    end

    def details_of_a_user
      # puts "To update your details please first enter your User ID"
      user_input = gets.chomp
      find_user = User.find(user_input)
      binding.pry
    end

    # def update
    #   puts "Your details are as follows:"
    #   print_user_details(user_id)
    #   what_next = prompt.select("Would you like to update one of these plants?", %w(Yes No))
    #   if what_next == "Yes"
    #     choosen_plant = prompt.select("Please select your chosen plant:", [user_id])
    #     purchase(choosen_plant)
    #
    #     Person.update(15, :user_name => 'Samuel', :group => 'expert')
    #
    #     menu
    #   else what_next == "No"
    #    menu
    #   end
    # else user_input == "return to menu"
    #  menu
    # end
    #   #find a users details
    #   #ask would you like to update your details y n
    #   #check - should i locate a specific suer to update first?
    #   update_user = prompt.collect do
    #     key(:first_name).ask('First name?', required: true)
    #     key(:second_name).ask('Second name?', required: true)
    #     key(:email).ask('Email?', required: true)
    #
    #     key(:address1).ask('First line address?', required: true)
    #     key(:address2).ask('Second line address?')
    #     key(:city).ask('City?', required: true)
    #     key(:post_code).ask('Post Code?', required: true)
    #   end

  #     User.update(update_user)
  # #then return_to_menu???
  #     menu
  #   end

    def all_purchases_for_a_user
      self.Purchases{|purchase| purchase.user_id == self}
    end

    def return
      #return a plant
      #find all plants purchased by a user
      all_purchases_for_a_user
      return_purchase = Purchase.all.find_by(user_input)
      return_purchase.destroy

      menu
    end

    def anything_else
      user_input = prompt.select("Is there anything else we can help you with today?", %w(Yes No))
      if user_input == "Yes"
        menu
     else user_input == "No"
       exit_app
     end
    end

  def exit_app
  	puts "Goodbye"
  end

end
