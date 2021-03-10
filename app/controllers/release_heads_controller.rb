class ReleaseHeadsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy edit new update]
  before_action :set_release_head, only: [:show, :edit, :update, :destroy]

  # GET /release_heads
  # GET /release_heads.json
  def index
    @release_heads = ReleaseHead.all
  end

  # GET /release_heads/1
  # GET /release_heads/1.json
  def show
  end

  # GET /release_heads/new
  def new
    @release_head = authorize ReleaseHead.new
  end

  # GET /release_heads/1/edit
  def edit
    authorize @release_head
  end

  # POST /release_heads
  # POST /release_heads.json
  def create
    authorize ReleaseHead
    @release_head = ReleaseHead.new(release_head_params)

    respond_to do |format|
      if @release_head.save
        format.html { redirect_to @release_head, notice: 'Release head was successfully created.' }
        format.json { render :show, status: :created, location: @release_head }
      else
        format.html { render :new }
        format.json { render json: @release_head.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_heads/1
  # PATCH/PUT /release_heads/1.json
  def update
    authorize ReleaseHead

    respond_to do |format|
      if @release_head.update(release_head_params)
        format.html { redirect_to @release_head, notice: 'Release head was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_head }
      else
        format.html { render :edit }
        format.json { render json: @release_head.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_heads/1
  # DELETE /release_heads/1.json
  def destroy
    authorize ReleaseHead

    @release_head.destroy
    respond_to do |format|
      format.html { redirect_to release_heads_url, notice: 'Release head was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release_head
      @release_head = ReleaseHead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def release_head_params
      params.require(:release_head).permit(:title, :disambiguation, :type, :brainz_code, :imdb_code, :tmdb_code, :wikidata_code, :artist_credit_id, :import_order_id)
    end
end
