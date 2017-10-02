class Api::V01::MusicBrainzReleasesController < ApplicationController
  def create
    cache = ImportCache.new
    begin
      result =ImportBrainzRelease.perform(brainz_params, cache)
    rescue ImportException => exception
      response.status = exception.status
      exception.render
    else
      response.content_type = 'application/vnd.api+json'
      response.status = 202
      render :json => {foo: 'bar'}
    end
  end

  private

  def brainz_params
    params.permit(data: {})
  end
end
