class AlbumHeadsController < ApplicationController
  def index
    @album_heads = AlbumHead.all
  end

  def show
    @album_head = AlbumHead.find(params[:id])
  end
end
