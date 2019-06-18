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
    user_input = prompt.select("How can we help?
    Please enter one of the following options:", %w(register search update refund exit))
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

  def register
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

    menu
  end

  # def details_of_a_user
  #   User.find_by(:id)
  #   binding.pry
  # end
  #
  # def all_purchases_for_a_user
  #   self.Purchases{|purchase| purchase.user_id == self}
  # end

  def search
    user_input = prompt.select("How would you like to search for a plant?", %w(search_climate search_cost return_to_menu))
    if user_input == "search_climate"
      search_climate #add this method
    elsif user_input == "search_cost"
     search_cost #add this method
   else user_input == "return_to_menu"
     menu
   end
  end

  def search_climate
    user_input = prompt.select("Please select one of the following climate options which best represents a quality of your home environment:", ["humidity", "direct sunlight", "indirect light", "shade", "hot dry climate", "return to menu"])
    if user_input != "return to menu"
      plants_match = Plant.all.select{|plant| plant.preferences == user_input.to_s}
      binding.pry
    else user_input == "return to menu"
     menu
    end
    plants_match
  end
    #binding.pry

  # def plant_price
  #   Plant.all.select{|plant| plant.price}
  #
  # end

  def search_cost
    puts "We can provide plants to suit most budgets! Please enter your maximum budget to see all plants within your price range:"
    user_input = gets.chomp.to_i
    plants_in_budget = Plant.all.select{|plant| plant.price <= user_input}
  #  binding.pry
    #then either purchase plant or return to options menu
  end

  # def purchase_plant
  #   new_purchase = prompt.collect do
  #     key(:date).ask('First name?', required: true) #date on initialization??
  #     key(:user_id).ask('Second name?', required: true)
  #     key(:plant_id).ask('Email?', required: true) validation to integer
  #
  #     key(:price).ask('First line address?', required: true)
  #     key(:address2).ask('Second line address?')
  #     key(:city).ask('City?', required: true)
  #     key(:condition).ask('Post Code?', required: true)
  #   end
  #   Purchase.create(new_purchase)
  #     puts "Your new plant is purchased!"
  #
  #   menu
  # end

  def update
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

    menu

  end

  def return
    #return a plant
    #find all plants purchased by a user
    #pick a plant to delete
    return_purchase = Purchase.find_by(user_id: " " )
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

#%w(humidity direct_sunlight indirect_light shade hot_dry_climate return_to_menu))
