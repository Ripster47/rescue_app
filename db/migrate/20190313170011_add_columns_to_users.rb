class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accomodations, :integer
    add_column :users, :rent, :boolean
    add_column :users, :children, :boolean
    add_column :users, :adult, :boolean
    add_column :users, :volunteer, :boolean
    add_column :users, :foster, :boolean
    add_column :users, :usark, :boolean
    add_column :users, :exotic_vet, :boolean
    add_column :users, :ever_owned, :boolean
    add_column :users, :care, :boolean
    add_column :users, :provisions, :boolean
    add_column :users, :bequest, :boolean
  end
end
