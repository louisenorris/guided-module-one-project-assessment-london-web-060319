class User < ActiveRecord::Base
  has_many :purchases
  has_many :plants, through: :purchases

  # def all_purchases_for_a_user
  #   self.Purchases{|purchase| purchase.user_id == self}
  # end

end
