class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:add_coins]
  def index
    @wishes = Wish.last(4)
    # if current_user
    #   redirect_to wishes_path
    # end
  end

  def add_coins
    if current_user.has_enough_coins?
      @alert = "You have enough diamonds to use"
      #redirect_to root_path
      #flash[:notice] = "You have enough coins come back when you don't have any"
    else
      if !current_user.last_donation_within_threshold?
        current_user.add_coins!(1 + rand(100))
        @alert =  "Thank you #{current_user.username} for waiting you now have #{current_user.coins} diamonds"
      else
        @alert = "Hi #{current_user.username} come back later or please wait "
      end
    end

  end
end
