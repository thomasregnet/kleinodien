# frozen_string_literal: true

# Takes an uri and stores an ImportOrder
class UriImportOrdersController < ApplicationController
  # TODO: user must also have the right to order import_orders
  before_action :authenticate_user!

  def new
    @import_order = ImportOrder.new
  end

  def create
    @import_order = ImportOrder.new(uri: uri_string, user: current_user)
    if @import_order.save
      flash[:success] = 'Successfully added your import order'
    else
      flash[:error] = "can't persist import from #{uri_string}"
    end

    # use "redirect_to" instead of "render" to get an new ImportOrder instance
    redirect_to new_uri_import_order_path
  end

  private

  def uri_string
    import_order_params[:uri]
  end

  def import_order_params
    params.require(:import_order).permit(:uri)
  end
end
