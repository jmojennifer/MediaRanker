class AlbumsController < ApplicationController

  def index
    @albums = Album.all
    @albums = @albums.order(ranking: :desc)
  end

  def show
    begin
      @album = Album.find(params[:id])
    rescue ActiveRecord::RecordNotFound => err
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_path(@album.id)
    else
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_path
  end

  def upvote
    @album = Album.find(params[:id])
    @album.upvote
    redirect_to album_path(params[:id])
  end

private

  def album_params
    params.require(:album).permit(:name, :artist, :description)
  end

end
