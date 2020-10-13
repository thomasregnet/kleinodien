# frozen_string_literal: true

# Controller for releases, albums, singles...
class ReleasesController < ApplicationController
  def index
    @releases = Release.all
  end

  def show
    # @release = Release.find(params[:id])
    @release = Release.includes(subsets: [tracks: :piece]).find(params[:id])
  end
end
