class Product < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'

  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per 9

  searchable do
    text :title, boost: 2
    text :item_id
    text :manufacturer
  end

  belongs_to :category
  has_many :line_items
  has_many :carts, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

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

  private

  # Make sure a product is not referenced by any line item
  def ensure_not_referenced_by_any_line_item
    if line_item.empty?
      return true
    else
      errors.add(:base, "Line items exist")
      return false
    end
  end
end
