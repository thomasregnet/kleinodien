class UriImportOrdersController < ApplicationController
  def new
    @import_order = ImportOrder.new
  end

  def create
    if class_name
      @import_order = class_name.constantize.new(import_order_params)
    else
      flash[:error] = "can't import from #{uri_string}"
    end

    # @import_order = ImportOrder.new(import_order_params)
    @import_order.user = current_user

    if @import_order.save
      flash[:success] = 'Successfully added your import order'
    else
      flash[:error] = 'Failed to queue import order'
    end

    render :new
  end

  private

  def class_name
    @class_name ||= GetImportOrderClassNameFromUri.call(uri_string)
  end

  def uri_string
    @uri_string ||= params.require(:import_order).permit(:uri)
  end

  def import_order_params
    params.require(:import_order).permit(:uri)
  end
end
