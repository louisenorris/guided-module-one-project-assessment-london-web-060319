class AddConditionColumnToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :condition, :text
  end
end
