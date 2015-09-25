class AlbumHeadsController < ApplicationController
  def index
    @album_heads = AlbumHead.all
  end

  def show
  end
end
