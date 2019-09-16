# frozen_string_literal: true

# Controller for Heaps, Albums, Singles...
class ReleasesController < ApplicationController
  def index
    @release = Release.all
  end

  def show
    @release = Release.find(params[:id])
  end
end
