class AddColumnToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :animal_type, :string
  end
end
