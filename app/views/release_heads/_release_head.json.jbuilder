json.extract! release_head, :id, :title, :disambiguation, :type, :brainz_code, :imdb_code, :tmdb_code, :wikidata_code, :artist_credit_id, :import_order_id, :created_at, :updated_at
json.url release_head_url(release_head, format: :json)
