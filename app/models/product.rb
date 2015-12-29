class Product < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'

  belongs_to :category
  has_many :cart_items
  # before_destroy :ensure_not_referenced_by_any_cart_item
  paginates_per 9

  validates :category_id, presence: true
  validates :image, presence: true
  validates :item_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :manufacturer, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 },
                    format: { with: /\A\d+(?:\.\d{0,2})?\z/ }

  mount_uploader :image, ImageUploader
end
