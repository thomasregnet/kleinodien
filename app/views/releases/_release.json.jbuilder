json.extract! release, :id, :title, :barcode, :date, :data_mask, :type, :version, :brainz_code, :discogs_code, :imdb_code, :tmdb_code, :wikidata_code, :area_id, :artist_credit_id, :import_order_id, :language_id, :release_head_id, :script_id, :created_at, :updated_at
json.url release_url(release, format: :json)
