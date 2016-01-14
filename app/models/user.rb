class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :cart, dependent: :destroy
  has_many :orders
  paginates_per 20
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :first_name, :last_name, presence: true

  def personal_cart
    Cart.create(user: self) unless self.cart.present?
    self.cart
  end
end
