class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]


  def index
    @pictures = Picture.all
    @most_recent_pictures = Picture.most_recent_five
    @pictures_older_than_month = Picture.created_before(Time.now - 1.month)
    @picture = Picture
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def show

  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user = current_user
    if @picture.save
      redirect_to "/pictures"
    else
      render :new
    end
  end

  def edit
  end

  def update

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user = current_user

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end

  end

  def destroy
    @picture.destroy
    redirect_to "/pictures"
  end



end
