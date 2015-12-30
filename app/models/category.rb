class Category < ActiveRecord::Base
  CATEGORIES = { "Arts & Photography" => "1",
                 "History" => "9",
                 "Literature & Fiction" => "17",
                 "Science & Math" => "75",
                 "Computers & Technology" => "5" }

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :products, dependent: :destroy
  validates :title, presence: true
end
