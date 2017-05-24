class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wishes, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy

  THRESHOLD_TIME = 15 * 60

  def has_enough_coins?
    coins > 0
  end

  def last_donation_within_threshold?
    return false if donations.empty?

    time_elapsed_in_second <=  THRESHOLD_TIME
  end

  def substract_coins!(amount = 1)
    decrement!(:coins, amount)
  end

  def add_coins!(amount = 1)
    increment!(:coins, amount)
  end

  def time_elapsed_in_second
    (Time.current - donations.last.created_at).to_i
  end

  def time_left_in_second
     THRESHOLD_TIME - time_elapsed_in_second
  end
end

#  has_many :places, through: :place_categories
#  has_many :categories, through: :place_categories
