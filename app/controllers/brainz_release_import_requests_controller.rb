class BrainzReleaseImportRequestsController < ApplicationController
  def new
    # @brainz_release_import_request = BrainzReleaseImportRequest.new
    @import_request = ImportRequest.new
  end

  def create
    # BrainzReleaseImportRequest.perform(import_params)
    @import_request = ImportRequest.brainz_release(import_params)
    QueueImportService.call(importer_name: 'brainz', request: @import_request)
  end

  private

  def import_params
    # params.require(:brainz_release_import_request).permit(:code)
    params.require(:import_request).permit(:code)
  end
end
