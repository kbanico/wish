class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :wish

  after_create :send_donation_email

  def send_donation_email
    NotificationMailer.donation_added(self).deliver
  end


end


