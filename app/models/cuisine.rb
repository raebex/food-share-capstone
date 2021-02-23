class Cuisine < ApplicationRecord
  has_many :user_cuisines
  has_many :users, through: :user_cuisines
end
