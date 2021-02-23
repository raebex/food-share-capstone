class CartedDish < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :order, optional: true
end
