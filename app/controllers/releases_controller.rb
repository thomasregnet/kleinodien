# frozen_string_literal: true

class ReleasesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy edit new update]
  before_action :set_release, only: %i[show edit update destroy]

  # GET /releases
  # GET /releases.json
  def index
    # @releases = Release.all
    @releases = Release.includes(:artist_credit).page
  end

  # GET /releases/1
  # GET /releases/1.json
  def show; end

  # GET /releases/new
  def new
    @release = authorize Release.new
  end

  # GET /releases/1/edit
  def edit
    authorize @release
  end

  # POST /releases
  # POST /releases.json
  def create
    authorize Release
    @release = Release.new(release_params)

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /releases/1
  # PATCH/PUT /releases/1.json
  def update
    authorize Release

    respond_to do |format|
      if @release.update(release_params)
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    authorize Release

    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'Release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_release
    @release = Release.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def release_params
    params.require(:release).permit(:title, :barcode, :date, :date_mask, :type, :version, :brainz_code,
                                    :discogs_code, :imdb_code, :tmdb_code, :wikidata_code, :area_id, :artist_credit_id, :import_order_id, :language_id, :release_head_id, :script_id)
  end
end
