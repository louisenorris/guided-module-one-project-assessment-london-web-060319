class User < ActiveRecord::Base
  has_many :purchases
  has_many :plants, through: :purchases

  # def all_purchases_for_a_user
  #   self.Purchase.all.select{|purchase| purchase.user_id == self}
  #   binding.pry
  # end

end
