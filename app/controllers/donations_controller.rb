class DonationsController < ApplicationController
  before_action :authenticate_user!
  def create
    @wish = Wish.find(params[:wish_id])

    if current_user.coins >= donation_params[:amount].to_i
      #update wish coin bucket
      new_amount =@wish.coin_bucket + donation_params[:amount].to_i
      @wish.update_attributes(coin_bucket: new_amount)

      #update user coins
      new_user_coins = current_user.coins-donation_params[:amount].to_i
      current_user.update_attributes(coins: new_user_coins)

      #make the donation for viewing purpose later
      @wish.donations.create(donation_params.merge(user: current_user))
      # current_user.update_attributes(coins: new_user_coins)
      # @wish.update_attributes(coin_bucket: @wish.coin_bucket+new_amount)

      if @wish.save
        #random = rand(Wish.count)+1
        #@wish = Wish.find(random)

        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      else
        flash[:alert] = "Check The form something went wrong"
        redirect_to :back
      end
      # redirect_to wish_path(@wish)
      #redirect_to :back
    else
      #check time left before giving more coins
      #last donation time in mins
      last_donation_time = current_user.donations.last.created_at.strftime("%M").to_i

      #current time in minutes
      time_now = Time.now.strftime("%M").to_i

      wait_time = 15 # waiting time for a new wish
      diff = (last_donation_time - time_now).abs

      time_left = (wait_time - diff).abs





      puts "#{time_left} time left #{wait_time} is wait time #{time_left < wait_time} is time left < wait time"
      # maybe redirect them to a page to request for more coins
      if diff < wait_time
        flash[:alert] = "Sorry you don't have enough coins try again in #{time_left} minutes"
      else
        flash[:notice] = "Thank you for waiting now you have more coins"
        current_user.update_attributes(coins: 100)
      end
      redirect_to :back
    end
  end




  private
    def donation_params
      params.require(:donation).permit(:amount)
    end

end
