class UploadPhotosController < ApplicationController

  def index
    @photos = Photo.all
    @user = current_user
    if current_user && current_user.admin == true
      @checkuser = "USER IS ADMIN"
    else
      @checkuser = "USER IS NOT ADMIN"
    end
  end


  def new
    @photo = Photo.new
  end

  def create

    if current_user && current_user.admin == true
      @photo = current_user.photos.create(photo_params)
      if @photo.errors.any?
        flash[:alert] = "THERE WAS AN ERROR"
        redirect_to root_path
      else
        flash[:alert] = "Everything ok"
        redirect_to :back
      end
    else
      flash[:alert] = "SORRY YOUR NOT ADMIN"
      redirect_to root_path
    end
  end


  def destroy

  end

  private
  def photo_params
    params.require(:photo).permit(:caption, :picture)
  end
end
