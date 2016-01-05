class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def add_product(product_id, qty=1)
    current_item = line_items.where(product_id: product_id).first
    if current_item
      current_item.quantity += qty
    else
      current_item = line_items.build(product_id: product_id, quantity: qty)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |line_item| line_item.total_price }
  end
end
