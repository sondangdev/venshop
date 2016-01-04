class Order < ActiveRecord::Base
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
end
