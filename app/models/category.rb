class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  validates :title, presence: true

  CATEGORIES = { "Arts & Photography" => "1",
                 "History" => "9",
                 "Literature & Fiction" => "17",
                 "Science & Math" => "75",
                 "Computers & Technology" => "5" }
end
