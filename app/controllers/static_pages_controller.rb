class StaticPagesController < ApplicationController
  def index
    @wishes = Wish.last(4)
    # if current_user
    #   redirect_to wishes_path
    # end
  end
end
