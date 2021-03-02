class Order < ApplicationRecord
  belongs_to :user
  has_many :carted_dishes
  has_many :dishes, through: :carted_dishes
  belongs_to :chef, class_name: "User"

  def tax
    subtotal * 0.09
  end

  def total
    tax + subtotal
  end
end
