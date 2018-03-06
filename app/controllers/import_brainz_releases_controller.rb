class ImportBrainzReleasesController < ApplicationController
  def new
    @import_brainz_release = Import::BrainzRelease.new
  end

  def create
    Import::BrainzRelease.perform(import_params)
  end

  private

  def import_params
    params.require(:import_brainz_release).permit(:code)
  end
end
