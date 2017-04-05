class DonationsController < ApplicationController
  before_action :authenticate_user!
  def create
    @wish = Wish.find(params[:wish_id])

    #update wish coin bucket
    new_amount =@wish.coin_bucket + donation_params[:amount].to_i
    @wish.update_attributes(coin_bucket: new_amount)

    #update user coins
    new_user_coins = current_user.coins-params[:amount].to_i
    current_user.update_attributes(coins: new_user_coins)

    #make the donation for viewing purpose later
    @wish.donations.create(donation_params.merge(user: current_user))
    # current_user.update_attributes(coins: new_user_coins)
    # @wish.update_attributes(coin_bucket: @wish.coin_bucket+new_amount)

    redirect_to wish_path(@wish)
  end




  private
    def donation_params
      params.require(:donation).permit(:amount)
    end

end
