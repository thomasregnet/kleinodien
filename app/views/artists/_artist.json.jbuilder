json.extract! artist, :id, :name, :sort_name, :disambiguation, :begin_date, :begin_date_mask, :end_date, :end_date_mask, :brainz_code, :discogs_code, :imdb_code, :tmdb_code, :wikidata_code, :import_order_id, :created_at, :updated_at
json.url artist_url(artist, format: :json)
