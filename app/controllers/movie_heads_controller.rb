class MovieHeadsController < ApplicationController
  def index
    @movie_heads = MovieHead.all
  end

  def show
    @movie_head = MovieHead.find(params[:id])
  end
end
