require 'net/http'
require 'uri'
class WishesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wishes = Wish.all.order("created_at DESC").paginate(:page => params[:page], per_page: 4)
    @donation = Donation.new
  end


  def new
    #unsplash background on form
    # res = Net::HTTP.get_response(URI('https://source.unsplash.com/random'))
    # $req = res['location']
    # @req = $req

    #gets the last picture in the uploaded database
    #@req = Photo.last.picture
    @req = view_context.image_path 'default.jpg'
    @wish = Wish.new
    @photos = Photo.all
  end

  def create

    @wish = current_user.wishes.new(wish_params)
    if @wish.save
      redirect_to wish_path(@wish)
    else
      @photos = Photo.all
      render :new, status: :unprocessable_entity
    end
    # render json: @wish
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
      params.require(:wish).permit(:description,:url)
    end
end
