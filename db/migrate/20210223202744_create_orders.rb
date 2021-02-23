class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :subtotal, precision: 5, scale: 2
      t.boolean :delivery, default: false
      t.datetime :ready_time
      t.string :status
      t.integer :chef_id

      t.timestamps
    end
  end
end
