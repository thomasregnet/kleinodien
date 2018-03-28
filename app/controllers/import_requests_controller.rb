class ImportRequestsController < ApplicationController
  def new
    @import_request = ImportRequest.new
  end

  def create
    @import_request = ImportRequest.new(import_params)
  end

  private

  def import_params
    params.require(:import_request).permit(:code, :type)
  end
end
