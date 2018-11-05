# frozen_string_literal: true

# Takes an uri and stores an ImportOrder
class UriImportOrdersController < ApplicationController
  def new
    @import_order = ImportOrder.new
  end

  def create
    @import_order = BuildImportOrderFromUriService.call(uri_string)
    @import_order.state = 'pending'

    unless @import_order
      flash[:error] = "can't import from #{uri_string}"
    end

    @import_order.user = current_user
    if @import_order.save
      flash[:success] = 'Successfully added your import order'
    end

    render :new
  end

  private

  def class_name
    @class_name ||= GetImportOrderClassNameFromUriService.call(uri_string)
  end

  def uri_string
    import_order_params[:uri]
  end

  def import_order_params
    params.require(:import_order).permit(:uri)
  end
end
