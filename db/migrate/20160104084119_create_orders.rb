class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :order_number
      t.text :address
      t.string :contact_number
      t.string :email
      t.string :pay_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
