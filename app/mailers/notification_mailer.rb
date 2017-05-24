class NotificationMailer < ApplicationMailer
  default from: "no-reply@wish-app.com"

  def comment_added(comment)
    @comment_user = comment.user.username
    @comment_message = comment.message
    @wish = comment.wish
    @wish_user = @wish.user
    mail(to: @wish_user.email, subject: "A comment has been added to your wish (#{@wish.description})")
  end

  def donation_added(donation)
    @donation_user = donation.user.username
    @wish = donation.wish
    @wish_user = @wish.user

    # I HAD TO ADD 1 TO THE TOTAL WISH COIN BUCKET

    @total_wish_coins = donation.wish.coin_bucket.to_i + 1

    mail(to: @wish_user.email, subject: "Someone supported your wish")

  end
end
