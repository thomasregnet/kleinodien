class AlbumReleasesController < ApplicationController
  def index
    @album_releases = AlbumRelease.all
  end

  def show
    @album_release = AlbumRelease.find(params[:id])
  end
end
