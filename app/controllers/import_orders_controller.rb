class ImportOrdersController < ApplicationController
  def new
    @import_order = ImportOrder.new
  end

  def create
    @import_order = ImportOrder.new(import_order_params)
    @import_order.user = current_user

    if @import_order.save!
      flash[:success] = 'Successfully added an import order'
    else
      flash[:error] = 'Failed to queue import order'
    end

    render :new
  end

  private

  def import_order_params
    params.require(:import_order).permit(:uri)
  end
end

