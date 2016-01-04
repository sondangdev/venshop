class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.timestamps null: false
      t.string :item_id
      t.string :title
      t.string :manufacturer
      t.text :description
      t.text :description
      t.date :publiscation_date
      t.string :image
      t.float :price, precision: 2, scale: 2
      t.references :category, index: true, foreign_key: true
    end
  end
end
