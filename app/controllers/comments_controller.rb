class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_wish

  def new
    @random_image_url = RandomImageService.random_image_url
  end

  def create
    comment = @wish.comments.new(comment_params.merge(user: current_user))
    if comment.save
      redirect_to wish_path(@wish)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :url)
  end

  def find_wish
    @wish = Wish.find(params[:wish_id])
  end
end
