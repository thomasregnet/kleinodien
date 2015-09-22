class AlbumReleasesController < ApplicationController
  def index
    @album_releases = AlbumRelease.all
  end
end
