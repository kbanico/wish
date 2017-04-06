class WishesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @wishes = Wish.all
    @donation = Donation.new
  end


  def new
    @wish = Wish.new
  end

  def create
    @wish = current_user.wishes.create(wish_params)
    if @wish.valid?
      redirect_to wish_path(@wish)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @donation = Donation.new
    @wish = Wish.find(params[:id])

  end

  private
    def wish_params
      params.require(:wish).permit(:description)
    end
end
