class AddBalanceColumnUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :balance, :integer
  end
end
