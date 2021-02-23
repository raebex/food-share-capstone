class CreateDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2
      t.text :description
      t.integer :user_id
      t.string :image_url
      t.string :portion_size
      t.boolean :featured, default: false

      t.timestamps
    end
  end
end
