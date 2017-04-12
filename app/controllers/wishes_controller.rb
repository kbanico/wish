require 'net/http'
require 'uri'
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

    # uri = URI('https://source.unsplash.com/category/nature')
    # req = Net::HTTP.get(uri)
    # new_req = URI.extract(req)
    # @req = new_req

    # unsplash
    res = Net::HTTP.get_response(URI('https://source.unsplash.com/random'))
    @req = res['location']

    if @wish.url.nil?
      @wish.update_attributes(url: @req)
    end



  end

  private
    def wish_params
      params.require(:wish).permit(:description)
    end
end
