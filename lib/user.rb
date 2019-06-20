class User < ActiveRecord::Base
  has_many :purchases
  has_many :plants, through: :purchases

  # def self.find_by_color(color)
  #   results = Plant.all.select{|plant| plant.color == color}
  #   results.map{|plant| puts "#{plant.species} - #{plant.color}"}
  # end
  #
  # # def find_balance(@user_id)
  #   user_balance = User.all.select{|user| user.balance == self}
  #   puts "Your current balance is #{user_balance}."
  #   menu
  # end

  # def all_purchases_for_a_user
  #   self.Purchase.all.select{|purchase| purchase.user_id == self}
  #   binding.pry
  # end

end
