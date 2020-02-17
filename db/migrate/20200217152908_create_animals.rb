class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :animal_type
      t.string :species
      t.integer :price_per_day
      t.string :location
      t.text :description
      t.boolean :display, default: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
