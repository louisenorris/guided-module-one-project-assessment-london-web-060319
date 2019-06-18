class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table(:users) do |t|
      t.text :first_name
      t.text :second_name
      t.text :email
      t.text :address1
      t.text :address2
      t.text :city
      t.text :post_code
    end
  end
end
