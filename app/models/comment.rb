class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wish
  validates :message, presence: true, length: {minimum: 3, maximum: 130}

end
