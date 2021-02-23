class CreateCartedDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :carted_dishes do |t|
      t.integer :dish_id
      t.integer :quantity
      t.string :status, default: "carted"
      t.integer :order_id
      t.integer :user_id

      t.timestamps
    end
  end
end
