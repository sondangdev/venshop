class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :item_id
      t.string :title
      t.string :manufacturer
      t.text :description
      t.text :description
      t.date :publiscation
      t.string :image
      t.float :price
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
