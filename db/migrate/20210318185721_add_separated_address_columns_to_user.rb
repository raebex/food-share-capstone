class AddSeparatedAddressColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column  :users, :street, :string
    add_column  :users, :city, :string
    add_column  :users, :state, :string
    add_column  :users, :zip_code, :string
    remove_column :users, :address, :string
  end
end
