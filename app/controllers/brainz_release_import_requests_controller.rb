class BrainzReleaseImportRequestsController < ApplicationController
  def new
    @brainz_release_import_request = BrainzReleaseImportRequest.new
  end

  def create
    BrainzReleaseImportRequest.perform(import_params)
  end

  private

  def import_params
    params.require(:brainz_release_import_request).permit(:code)
  end
end
