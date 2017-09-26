class Api::V01::MusicBrainzReleasesController < ApplicationController
  def create
    x = brainz_params
  end

  private

  def brainz_params
    # params.require(:data).permit(:type)
    params.require(:data).require(:type)
  end
end
