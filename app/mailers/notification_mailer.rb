class NotificationMailer < ApplicationMailer
  default from: "no-reply@wish-app.com"

  def comment_added(comment)
    @comment_user = comment.user.username
    @comment_message = comment.message
    @wish = comment.wish
    @wish_user = @wish.user
    mail(to: @wish_user.email, subject: "A comment has been added to your wish (#{@wish.description})")
  end

  def donation_added

  end
end
