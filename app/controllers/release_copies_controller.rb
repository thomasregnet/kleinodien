class ReleaseCopiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_release_copy, only: [:show, :edit, :update, :destroy]

  # GET /release_copies
  # GET /release_copies.json
  def index
    @release_copies = ReleaseCopy.all
  end

  # GET /release_copies/1
  # GET /release_copies/1.json
  def show
  end

  # GET /release_copies/new
  def new
    @release_copy = ReleaseCopy.new
    authorize @release_copy
  end

  # GET /release_copies/1/edit
  def edit
  end

  # POST /release_copies
  # POST /release_copies.json
  def create
    @release_copy = ReleaseCopy.new(release_copy_params.merge(user: current_user))
    authorize @release_copy

    respond_to do |format|
      if @release_copy.save
        format.html { redirect_to @release_copy, notice: 'Release copy was successfully created.' }
        format.json { render :show, status: :created, location: @release_copy }
      else
        format.html { render :new }
        format.json { render json: @release_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_copies/1
  # PATCH/PUT /release_copies/1.json
  def update
    respond_to do |format|
      if @release_copy.update(release_copy_params)
        format.html { redirect_to @release_copy, notice: 'Release copy was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_copy }
      else
        format.html { render :edit }
        format.json { render json: @release_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_copies/1
  # DELETE /release_copies/1.json
  def destroy
    @release_copy.destroy
    respond_to do |format|
      format.html { redirect_to release_copies_url, notice: 'Release copy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release_copy
      @release_copy = ReleaseCopy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def release_copy_params
      params.require(:release_copy).permit(:type, :release_head_id, :release_id, :user_id)
    end
end
