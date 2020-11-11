class ReleaseImagesController < ApplicationController
  before_action :set_release_image, only: [:show, :edit, :update, :destroy]

  # GET /release_images
  # GET /release_images.json
  def index
    @release_images = ReleaseImage.all
  end

  # GET /release_images/1
  # GET /release_images/1.json
  def show
  end

  # GET /release_images/new
  def new
    @release_image = ReleaseImage.new
  end

  # GET /release_images/1/edit
  def edit
  end

  # POST /release_images
  # POST /release_images.json
  def create
    @release_image = ReleaseImage.new(release_image_params)

    respond_to do |format|
      if @release_image.save
        format.html { redirect_to @release_image, notice: 'Release image was successfully created.' }
        format.json { render :show, status: :created, location: @release_image }
      else
        format.html { render :new }
        format.json { render json: @release_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_images/1
  # PATCH/PUT /release_images/1.json
  def update
    respond_to do |format|
      if @release_image.update(release_image_params)
        format.html { redirect_to @release_image, notice: 'Release image was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_image }
      else
        format.html { render :edit }
        format.json { render json: @release_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_images/1
  # DELETE /release_images/1.json
  def destroy
    @release_image.destroy
    respond_to do |format|
      format.html { redirect_to release_images_url, notice: 'Release image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release_image
      @release_image = ReleaseImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def release_image_params
      params.require(:release_image).permit(:front, :back, :note, :release_id, :archive_org_code)
    end
end
