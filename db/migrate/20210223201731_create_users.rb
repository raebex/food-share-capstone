class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :image_url
      t.string :email
      t.string :password_digest
      t.boolean :chef, default: false
      t.text :bio
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
