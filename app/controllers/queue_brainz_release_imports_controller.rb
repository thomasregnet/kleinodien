class QueueBrainzReleaseImportsController < ApplicationController
  def new
    @queue_brainz_release_import = QueueBrainzReleaseImport.new
  end

  def create
    x = QueueBrainzReleaseImport.perform(import_params)
  end

  private

  def import_params
    params.require(:queue_brainz_release_import).permit(:code)
  end
end
