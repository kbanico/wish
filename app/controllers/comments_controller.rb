class CommentsController < ApplicationController
  before_action :authenticate_user!
  # unsplash


  def new

    #unsplash background on form
    res = Net::HTTP.get_response(URI('https://source.unsplash.com/random'))
    $req = res['location']
    @req = $req

    @wish = Wish.find(params[:wish_id])
    @comment = Comment.new
  end

  def create
    @wish = Wish.find(params[:wish_id])
    @wish.comments.create(comment_params.merge(user: current_user))

    @comment = @wish.comments.last
    if @comment.save
      @wish.comments.last.update_attributes(url: $req)
      @wish.save
      redirect_to  wish_path(@wish)
    else
      flash[:error] = "Something went wrong"
      render :new
    end



    #  # unsplash
    # res = Net::HTTP.get_response(URI('https://source.unsplash.com/random'))
    # @req = res['location']


  end

  private
  def comment_params
    params.require(:comment).permit(:message)
  end
end
