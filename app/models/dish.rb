class Dish < ApplicationRecord
  belongs_to :user
  has_many :carted_dishes
  has_many :orders, through: :carted_dishes
end
