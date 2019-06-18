class CommandLineInterface

  def greet
    puts 'Welcome to the Urban Jungle, the best source for indoor plants outside of your home!'
  end

#instead of options if/else just select from a dropdown menu - tty prompt select!!
  def menu
    puts "How can we help?" #add a v short time delay
    puts "Please enter one of the following options:
- register : sign up as a new Customer
- search : search for a plant to purchase
- update : update your Customer details
- refund : return a plant
- exit : exit this program" #USE TTY PROMPT SELECT
    user_input = gets.chomp
    until user_input == "exit"
      if user_input == "register"
        register #add this method
      elsif user_input == "search"
        search #add this method
      elsif user_input == "update"
        update #add this method
      elsif user_input == "refund"
        refund #add this method
      elsif user_input == "exit"
  		  exit_app
  		else
  			"Invalid entry" #go back to options message??
  		end
	   end
	  exit_app
  end

  def register #form to fill in and collect each property?
    #use tty prompt collect
    User.create(first_name, second_name, email, address1, address2, city, post_code)
    #return to options menu
  end

  def search
    puts "How would you like to search for a plant?" #add in tty prompt SELECT?
    #would you like to search by price or environment?
  end

  def search_climate
    puts "Thinking of adding some much needed foliage to your home but not sure what plants would thrive in it's microclimate? We can help you turn you living space into an Urban Jungle!"
    puts "Please select one of the following climate options:
    - humidity
    - direct sunlight
    - indirect light
    - shade
    - hot dry climate
    - menu : return to main menu"
    #eg find all plants which prefer a shady corner
    #Puchase.all.select{|purchase| purchase.}
    user_input = gets.chomp
    Plant.all.select{|plant| plant.preferences == user_input}
    binding.pry
  end

  def search_cost
    puts "How much do you have to spend? We can provide plants to suit most budgets!"
    puts "Please enter your maximum budget to see all plants within your price range:"
    #eg find all plants which prefer a shady corner
    #Puchase.all.select{|purchase| purchase.}
    user_input = gets.chomp
    Plant.all.select{|plant| plant.price < user_input}
    #then either purchase plant or return to options menu
  end

  def purchase_plant
    #purchase a plant
    Purchase.create(#add arguments
    )
  end

  def update
    #update Cusomer details
  end

  def return
    #return a plant
  end

  def anything_else
    #can we help we ahything else? - yes return to options menu, no exit
  end

def exit_app
	puts "Goodbye"
end
