class Order < ApplicationRecord
  belongs_to :user
  has_many :carted_dishes
  has_many :dishes, through: :carted_dishes
  belongs_to :chef, class_name: "User"
end
