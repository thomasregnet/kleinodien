class ImportOrdersController < ApplicationController
  def new
    @import_order = ImportOrder.new
  end
end

