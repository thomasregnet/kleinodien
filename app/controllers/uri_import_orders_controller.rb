# frozen_string_literal: true

# Takes an uri and stores an ImportOrder
class UriImportOrdersController < ApplicationController
  # TODO: user must also have the right to order import_orders
  before_action :authenticate_user!

  def new
    @import_order = ImportOrder.new
  end

  def create
    @import_order = BuildImportOrderFromUriService.call(
      uri_string: uri_string,
      user:       current_user
    )
    save_import_order

    # use "redirect_to" instead of "render" to get an new ImportOrder instance
    redirect_to new_uri_import_order_path
  end

  private

  def class_name
    @class_name ||= GetImportOrderClassNameFromUriService
                    .call(uri_string: uri_string)
  end

  def uri_string
    import_order_params[:uri]
  end

  def import_order_params
    params.require(:import_order).permit(:uri)
  end

  def save_import_order
    unless @import_order
      flash[:error] = "can't import from #{uri_string}"
      return
    end

    if @import_order.save
      flash[:success] = 'Successfully added your import order'
      return true
    else
      flash[:error] = "can't persist import from #{uri_string}"
    end

    false
  end
end
