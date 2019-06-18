class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table(:purchases) do |t|
      t.datetime :date
      t.integer :user_id
      t.integer :plant_id
      t.integer :price
      t.text :condition
    end
  end
end
