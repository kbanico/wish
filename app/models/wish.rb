class Wish < ApplicationRecord
  belongs_to :user
  has_many :donations
  validates :description, presence: true, length:{minimum:3, maximum: 130}
end
