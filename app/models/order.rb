class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :order_number, use: :slugged
  paginates_per 20

  has_many :line_items, dependent: :destroy
  belongs_to :user
  PAY_TYPES = [ "Cash on Delivery", "Credit Card", "Internet Banking" ]

  validates :order_number, presence: true, uniqueness: true
  validates :name, :email, :contact_number, :address, :pay_type, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def remove_stock_from_product
    line_items.each do |item|
      product = item.product
      product.stock -= item.quantity
      product.save
    end
  end

  def total_price
    line_items.to_a.sum { |line_item| line_item.total_price }
  end
end
