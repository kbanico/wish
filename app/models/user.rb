class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wishes
  has_many :donations
  has_many :comments

end

#  has_many :places, through: :place_categories
#  has_many :categories, through: :place_categories
