class UploadPhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin
      @photos = Photo.all
      @user = current_user
      if current_user && current_user.admin == true
        @checkuser = "USER IS ADMIN"
      else
        @checkuser = "USER IS NOT ADMIN"
      end
    else
      flash[:notice] = "Sorry you do not have permission to do that"
      redirect_to root_path
    end
  end


  def new
    @photo = Photo.new
  end

  def create

    if current_user && current_user.admin == true
      @photo = current_user.photos.create(photo_params)
      if @photo.errors.any?
        flash[:alert] = "The following errors prevented the upload #{@photo.errors.full_messages}"
        redirect_to root_path
      else
        flash[:notice] = "Upload success"
        redirect_to :back
      end
    else
      flash[:alert] = "Sorry you do not have permission to do that"
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
