class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.timestamps null: false
      t.integer :user_id
    end
  end
end
