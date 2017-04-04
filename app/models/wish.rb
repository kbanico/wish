class Wish < ApplicationRecord
  belongs_to :user
  has_many :donations through: :donations
  validates :description, presence: true, length:{minimum:3, maximum: 130}
end
#  has_many :places, through: :place_categories
#  has_many :categories, through: :place_categories
