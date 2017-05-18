class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wishes
  has_many :donations
  has_many :comments
  has_many :photos

  THRESHOLD_TIME = 1

  def has_enough_coins?
    coins > 0
  end

  def last_donation_within_threshold?
    return false if donations.empty?

    time_elapsed_in_second <=  THRESHOLD_TIME * 60
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

  def time_left_in_minute
     THRESHOLD_TIME - (time_elapsed_in_second / 60)
  end
end

#  has_many :places, through: :place_categories
#  has_many :categories, through: :place_categories
