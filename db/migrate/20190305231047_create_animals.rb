class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
      t.text :description
      t.boolean :adoptable
      t.text :medical_status
      t.integer :gender
      t.string :age
      t.string :image_url
      t.decimal :donation

      t.timestamps
    end
  end
end
