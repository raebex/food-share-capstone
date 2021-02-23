class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  
  has_many :orders
  has_many :dishes
  has_many :preorder_hours
  has_many :tickets, class_name: "Order", foreign_key: "chef_id"
  has_many :user_cuisines
  has_many :cuisines, through: :user_cuisines
end
