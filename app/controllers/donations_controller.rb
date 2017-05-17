class DonationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_wish

  def create
    amount = donation_params[:amount].to_i
    if current_user.has_enough_coins?
      unless @wish.add_donation(amount, current_user)
        flash[:alert] = "Check The form something went wrong"
      end
    else
      if current_user.last_donation_within_threshold?
        #flash[:alert] = "Sorry you don't have enough coins try again in #{current_user.time_left_in_minute} minutes"
        flash[:alert] = "Sorry you don't have enough coins"
      # else
      #   current_user.add_coins!(1 + rand(100))
      #   flash[:notice] = "Thank you for waiting now you have more coins"
      end
    end
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private
    def donation_params
      params.require(:donation).permit(:amount)
    end

    def find_wish
      @wish = Wish.find(params[:wish_id])
    end

end
