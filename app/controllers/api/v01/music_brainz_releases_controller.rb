class Api::V01::MusicBrainzReleasesController < ApplicationController
  def create
    x = brainz_params
    response.status = 200
    response.content_type = 'application/vnd.api+json'
    render :json => {}
  end

  private

  def brainz_params
    params.require(:data).require(:type)
  end
end
