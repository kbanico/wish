class WishesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wishes = Wish.all.order("created_at DESC")
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
    random = rand(Wish.count)+1
    @random = Wish.find(random)
    @donation = Donation.new
    @wish = Wish.find(params[:id])

    #comment
    @comment = Comment.new

  end

  private
    def wish_params
      params.require(:wish).permit(:description)
    end
end
