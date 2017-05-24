class NotificationMailer < ApplicationMailer
  default from: "no-reply@wish-app.com"

  def comment_added
    mail(to: "gasconjenn@gmail.com", subject: "A comment has been added to your wish")
  end

  def donation_added

  end
end
