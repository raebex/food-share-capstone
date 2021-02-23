class CreateUserCuisines < ActiveRecord::Migration[6.1]
  def change
    create_table :user_cuisines do |t|
      t.integer :cuisine_id
      t.integer :user_id

      t.timestamps
    end
  end
end
