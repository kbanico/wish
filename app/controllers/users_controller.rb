class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @wishes = Wish.order("created_at ASC").last(6)
    @comments = Comment.order("created_at ASC").last(6)
  end
end
