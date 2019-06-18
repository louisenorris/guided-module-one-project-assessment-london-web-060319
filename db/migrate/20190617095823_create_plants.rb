class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table(:plants) do |t|
      t.text :species
      t.text :preferences
      t.integer :price
    end
  end
end
