class Plant < ActiveRecord::Base
  has_many :purchases
  has_many :users, through: :purchases

  #find a plant by color
  def self.find_by_color(color)
    results = Plant.all.select{|plant| plant.color == color}
    results.map{|plant| puts "#{plant.species} - #{plant.color}"}
  end


end
