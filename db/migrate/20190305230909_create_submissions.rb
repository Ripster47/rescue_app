class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :animal_id
      t.integer :purpose
      t.integer :status
      t.text :relinquish_reason

      t.timestamps
    end
  end
end
