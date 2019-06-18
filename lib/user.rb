class User < ActiveRecord::Base
  has_many :purchases
  has_many :plants, through: :purchases
end
