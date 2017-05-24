class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wish
  validates :message, presence: true, length: {minimum: 3, maximum: 130}

  after_create :send_comment_email

  def send_comment_email
    NotificationMailer.comment_added(self).deliver
  end

end
