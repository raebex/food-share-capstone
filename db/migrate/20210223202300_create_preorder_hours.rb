class CreatePreorderHours < ActiveRecord::Migration[6.1]
  def change
    create_table :preorder_hours do |t|
      t.string :day_of_week
      t.time :open
      t.time :close
      t.integer :user_id

      t.timestamps
    end
  end
end
