class ChangeColumnsInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :accomodations, :integer
    add_column :users, :accommodations, :integer
    add_column :users, :permit, :boolean
  end
end
