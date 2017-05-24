class Wish < ApplicationRecord
  belongs_to :user
  has_many :donations, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :description, presence: true, length:{minimum:3, maximum: 130}

  def add_donation(amount, user)
    success = false
    self.transaction do
      donations.create!(amount: amount, user: user)
      user.substract_coins!
      increment!(:coin_bucket, amount)
      success = true
    end
    success
  end
end
#  has_many :places, through: :place_categories
#  has_many :categories, through: :place_categories
