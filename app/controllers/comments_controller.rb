class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @wish = Wish.find(params[:wish_id])
    @comment = Comment.new
  end

  def create
    @wish = Wish.find(params[:wish_id])
    @wish.comments.create(comment_params.merge(user: current_user))
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:message)
  end
end
