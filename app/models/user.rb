class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  
  has_many :orders
  has_many :carted_dishes, dependent: :destroy
  has_many :dishes, dependent: :destroy
  has_many :preorder_hours, dependent: :destroy
  has_many :tickets, class_name: "Order", foreign_key: "chef_id"
  has_many :user_cuisines, dependent: :destroy
  has_many :cuisines, through: :user_cuisines
end
