class Photo < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader

  validates :caption, presence: true, length: {minimum: 3, maximum: 100}
  validates :picture, presence: true
end
