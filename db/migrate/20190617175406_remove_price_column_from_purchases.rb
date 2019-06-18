class RemovePriceColumnFromPurchases < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :price
  end
end
