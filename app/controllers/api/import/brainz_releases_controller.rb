require 'import/brainz_release'

class Api::Import::BrainzReleasesController < ApplicationController
  def create
    Import::BrainzRelease.perform(params[:data])
  end
end
