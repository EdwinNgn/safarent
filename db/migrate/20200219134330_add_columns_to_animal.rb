class AddColumnsToAnimal < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :street, :string
    add_column :animals, :zipcode, :string
  end
end
