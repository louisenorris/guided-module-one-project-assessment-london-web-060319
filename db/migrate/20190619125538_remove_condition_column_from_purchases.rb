class RemoveConditionColumnFromPurchases < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :condition
  end
end
