# frozen_string_literal: true

class ImportOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_import_order, only: %i[show edit update destroy]

  # GET /import_orders
  # GET /import_orders.json
  def index
    # @import_orders = ImportOrder.includes(:import_queue, :user).all
    @import_orders = ImportOrder.includes(:import_queue, :user).page params[:page]
    authorize @import_orders
  end

  # GET /import_orders/1
  # GET /import_orders/1.json
  def show
    authorize @import_order
  end

  # GET /import_orders/new
  def new
    @import_order = ImportOrder.new
    authorize(@import_order)
  end

  # GET /import_orders/1/edit
  def edit
    authorize @import_order
  end

  # POST /import_orders
  # POST /import_orders.json
  def create
    @import_order = ImportOrder.new(import_order_params.merge(user: current_user))
    authorize @import_order

    respond_to do |format|
      if @import_order.save
        format.html { redirect_to @import_order, notice: 'Import order was successfully created.' }
        format.json { render :show, status: :created, location: @import_order }
      else
        format.html { render :new }
        format.json { render json: @import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /import_orders/1
  # PATCH/PUT /import_orders/1.json
  def update
    authorize @import_order
    respond_to do |format|
      if @import_order.update(import_order_params)
        format.html { redirect_to @import_order, notice: 'Import order was successfully updated.' }
        format.json { render :show, status: :ok, location: @import_order }
      else
        # format.html { render :edit }
        format.html { redirect_to edit_import_order_url(@import_order) }
        format.json { render json: @import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /import_orders/1
  # DELETE /import_orders/1.json
  def destroy
    authorize @import_order
    @import_order.destroy
    respond_to do |format|
      format.html { redirect_to import_orders_url, notice: 'Import order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import_order
    @import_order = ImportOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def import_order_params
    params.require(:import_order)
          .permit(
            :code, :state, :type, :uri, :user_id,
            :requests_count, :import_queue_id
          )
  end
end
