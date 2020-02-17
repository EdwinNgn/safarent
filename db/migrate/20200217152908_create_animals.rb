class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :animal_type
      t.integer :price_per_day
      t.string :location
      t.text :description
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
