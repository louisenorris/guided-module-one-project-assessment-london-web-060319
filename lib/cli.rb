class CommandLineInterface

attr_reader :prompt, :font, :pastel

def initialize
  @prompt = TTY::Prompt.new
  @font = TTY::Font.new(:doom)
  @pastel = Pastel.new
end

  def title
    puts pastel.green(font.write("Urban Jungle", letter_spacing: 2))
  end

  def greet
    puts 'Welcome to the Urban Jungle, the best source for indoor plants outside of your home!'
  end

  def menu
    user_input = prompt.select("Please select one of the following options:", %w(register search update refund exit))
       if user_input == "register"
         register
      elsif user_input == "search"
        search
      elsif user_input == "update"
        update #add this method
      elsif user_input == "refund"
        refund #add this method
      else user_input == "exit"
  		  anything_else
  		end
	  end

    def return_last_new_user
      return_details = User.all.last
      puts return_details
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
      User.create(new_user)
      puts "New User registration complete, please note your ID number:"
        #return details or at east user id for info
      return_last_new_user
      #binding.pry
      sleep(2)
      menu
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

    # def select_plant
    #   plant_select = prompt.select("Please select a plant. plants_match")
    # end

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
        #binding.pry
      else user_input == "return to menu"
       menu
      end
    end
      #binding.pry

    def search_cost
      puts "We can provide plants to suit most budgets! Please enter your maximum budget to see all plants within your price range:"
      user_input = gets.chomp.to_i
      plants_in_budget = Plant.all.select{|plant| plant.price <= user_input}

      plant_species = plants_in_budget.map{|plant| plant.species }

      puts plant_species

      menu
    #  binding.pry
      #then either purchase plant or return to options menu
    end

    # def purchase_plant

   #  user_input = prompt.select("Is there anything else we can help you with today?", %w(Yes No))
   #  if user_input == "Yes"
   #    menu
   # else user_input == "No"
   #   exit_app
   # end
    #   new_purchase = prompt.collect do
    #     key(:date).ask('First name?', required: true) # collects date on initialization??
    #     key(:user_id).ask('Second name?', required: true)
    #     key(:plant_id).ask('Email?', required: true) validation to integer
    #
    #     key(:price).ask('First line address?', required: true)
    #     key(:condition).ask('Post Code?', required: true)
    #   end
    #   Purchase.create(new_purchase)
    #     puts "Your new plant is purchased!"
    #
    #   menu
    # end

    def details_of_a_user
      # puts "To update your details please first enter your User ID"
      user_input = gets.chomp
      find_user = User.find(user_input)
      binding.pry
    end

    def update
      puts "To update your details please first enter your User ID"
      details_of_a_user
      #find a users details
      #ask would you like to update your details y n
      #check - should i locate a specific suer to update first?
      update_user = prompt.collect do
        key(:first_name).ask('First name?', required: true)
        key(:second_name).ask('Second name?', required: true)
        key(:email).ask('Email?', required: true)

        key(:address1).ask('First line address?', required: true)
        key(:address2).ask('Second line address?')
        key(:city).ask('City?', required: true)
        key(:post_code).ask('Post Code?', required: true)
      end

      User.update(update_user)
  #then return_to_menu???
      menu

    end

    def all_purchases_for_a_user
      self.Purchases{|purchase| purchase.user_id == self}
    end

    def return
      #return a plant
      #find all plants purchased by a user
      #pick a plant to delete
      return_purchase = Purchase.all.find_by(user_id: " " )
      return_purchase.delete

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
