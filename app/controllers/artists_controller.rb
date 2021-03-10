class ArtistsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy edit new update]
  before_action :set_artist, only: %i[show edit update destroy]

  # GET /artists or /artists.json
  def index
    @artists = Artist.all.page
  end

  # GET /artists/1 or /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    # authenticate_user!
    # @artist = Artist.new
    # authorize @artist
    @artist = authorize Artist.new
  end

  # GET /artists/1/edit
  def edit
    authorize @artist
  end

  # POST /artists or /artists.json
  def create
    authorize Artist
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: "Artist was successfully created." }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1 or /artists/1.json
  def update
    authorize Artist

    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: "Artist was successfully updated." }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1 or /artists/1.json
  def destroy
    authorize Artist
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: "Artist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name, :sort_name, :disambiguation, :begin_date, :begin_date_mask, :end_date, :end_date_mask, :brainz_code, :discogs_code, :imdb_code, :tmdb_code, :wikidata_code, :import_order_id)
    end
end
