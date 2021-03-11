# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_11_103938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "area_aliases", force: :cascade do |t|
    t.string "name", null: false
    t.string "sort_name", null: false
    t.boolean "gone"
    t.string "locale"
    t.string "type"
    t.bigint "area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "begin_date_year", limit: 2
    t.integer "begin_date_month", limit: 2
    t.integer "begin_date_day", limit: 2
    t.integer "end_date_year", limit: 2
    t.integer "end_date_month", limit: 2
    t.integer "end_date_day", limit: 2
    t.index ["area_id"], name: "index_area_aliases_on_area_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.string "sort_name", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "begin_date"
    t.integer "begin_date_mask", limit: 2
    t.date "end_date"
    t.integer "end_date_mask", limit: 2
    t.uuid "brainz_code"
    t.boolean "gone"
    t.bigint "import_order_id"
    t.index "lower((name)::text)", name: "index_areas_on_lower_name", unique: true
    t.index "lower((sort_name)::text)", name: "index_areas_on_lower_sort_name", unique: true
    t.index ["import_order_id"], name: "index_areas_on_import_order_id"
  end

  create_table "artist_credits", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "import_order_id"
    t.index ["import_order_id"], name: "index_artist_credits_on_import_order_id"
  end

  create_table "artist_credits_tags", id: false, force: :cascade do |t|
    t.integer "artist_credit_id", null: false
    t.integer "tag_id", null: false
    t.index ["artist_credit_id"], name: "index_artist_credits_tags_on_artist_credit_id"
    t.index ["tag_id"], name: "index_artist_credits_tags_on_tag_id"
  end

  create_table "artists", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "name", null: false
    t.citext "disambiguation"
    t.date "begin_date"
    t.integer "begin_date_mask", limit: 2
    t.date "end_date"
    t.integer "end_date_mask", limit: 2
    t.citext "sort_name"
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "wikidata_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.bigint "import_order_id"
    t.index ["brainz_code"], name: "index_on_artists_brainz_code", unique: true
    t.index ["discogs_code"], name: "index_on_artists_discogs_code", unique: true
    t.index ["import_order_id"], name: "index_artists_on_import_order_id"
    t.index ["wikidata_code"], name: "index_on_artists_wikidata_code", unique: true
  end

  create_table "artists_tags", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "tag_id", null: false
    t.index ["artist_id"], name: "index_artists_tags_on_artist_id"
    t.index ["tag_id"], name: "index_artists_tags_on_tag_id"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "sort_name"
    t.bigint "area_id"
    t.uuid "brainz_code"
    t.integer "discogs_code"
    t.integer "label_code"
    t.integer "tmdb_code"
    t.integer "wikidata_code"
    t.bigint "import_order_id"
    t.index "lower((name)::text)", name: "index_companies_on_lower_name", unique: true
    t.index ["area_id"], name: "index_companies_on_area_id"
    t.index ["import_order_id"], name: "index_companies_on_import_order_id"
  end

  create_table "company_roles", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "name", null: false
    t.index "lower((name)::text)", name: "index_company_roles_on_lower_name", unique: true
  end

  create_table "formats", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.text "abbr"
    t.index "lower(name)", name: "formats_lower_idx", unique: true
    t.index ["abbr"], name: "formats_abbr_key", unique: true
  end

  create_table "image_tags", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "image_tags_release_images", id: false, force: :cascade do |t|
    t.bigint "image_tag_id", null: false
    t.bigint "release_image_id", null: false
    t.index ["image_tag_id"], name: "index_image_tags_release_images_on_image_tag_id"
    t.index ["release_image_id"], name: "index_image_tags_release_images_on_release_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "coverartarchive_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "import_order_id"
    t.index ["import_order_id"], name: "index_images_on_import_order_id"
  end

  create_table "import_orders", force: :cascade do |t|
    t.text "code", null: false
    t.text "state", null: false
    t.text "type"
    t.text "uri"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requests_count"
    t.bigint "import_queue_id"
    t.bigint "import_order_id"
    t.index ["code", "type"], name: "index_unique_active_import_orders", unique: true, where: "(state = ANY (ARRAY['pending'::text, 'preparing'::text, 'persisting'::text]))"
    t.index ["import_order_id"], name: "index_import_orders_on_import_order_id"
    t.index ["import_queue_id"], name: "index_import_orders_on_import_queue_id"
    t.index ["user_id"], name: "index_import_orders_on_user_id"
    t.check_constraint "state = ANY (ARRAY['pending'::text, 'preparing'::text, 'persisting'::text, 'done'::text, 'failed'::text])", name: "import_orders_state_check1"
  end

  create_table "import_queues", force: :cascade do |t|
    t.text "about"
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "import_request_attempts", force: :cascade do |t|
    t.text "message"
    t.integer "status_code", limit: 2, null: false
    t.bigint "import_request_id", null: false
    t.datetime "created_at", null: false
    t.index ["import_request_id"], name: "index_import_request_attempts_on_import_request_id"
  end

  create_table "import_request_bodies", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "import_request_id", null: false
    t.datetime "created_at", null: false
    t.index ["import_request_id"], name: "index_import_request_bodies_on_import_request_id"
  end

  create_table "import_requests", force: :cascade do |t|
    t.text "code", null: false
    t.text "state", default: "pending", null: false
    t.text "type", null: false
    t.bigint "import_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attempts_count"
    t.string "uri", null: false
    t.index ["import_order_id"], name: "index_import_requests_on_import_order_id"
    t.check_constraint "state = ANY (ARRAY['pending'::text, 'running'::text, 'done'::text, 'failed'::text])", name: "import_orders_state_check"
  end

  create_table "iso3166_part1_countries", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "upper((code)::text)", name: "index_iso_3166_part1_countries_upper_code", unique: true
    t.index ["area_id"], name: "index_iso3166_part1_countries_on_area_id"
  end

  create_table "iso3166_part2_countries", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "upper((code)::text)", name: "index_iso_3166_part2_countries_upper_code", unique: true
    t.index ["area_id"], name: "index_iso3166_part2_countries_on_area_id"
  end

  create_table "iso3166_part3_countries", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "upper((code)::text)", name: "index_iso_3166_part3_countries_upper_code", unique: true
    t.index ["area_id"], name: "index_iso3166_part3_countries_on_area_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso_code_1"
    t.string "iso_code_2b"
    t.string "iso_code_2t"
    t.string "iso_code_3"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medium_formats", force: :cascade do |t|
    t.text "name", null: false
    t.text "explanation"
    t.integer "year", limit: 2
    t.uuid "brainz_code"
    t.bigint "import_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brainz_code"], name: "medium_formats_brainz_code_index", unique: true
    t.index ["import_order_id"], name: "index_medium_formats_on_import_order_id"
    t.index ["name"], name: "medium_formats_name_index", unique: true
  end

  create_table "original_exemplars", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "disambiguation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_original_exemplars_on_user_id"
  end

  create_table "participants", id: :serial, force: :cascade do |t|
    t.integer "position", null: false
    t.string "join_phrase"
    t.integer "artist_id", null: false
    t.integer "artist_credit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_participants_on_artist_id"
    t.index ["position", "artist_credit_id"], name: "index_participants_on_artist_credit_id_and_no", unique: true
  end

  create_table "ph_labels", id: :serial, force: :cascade do |t|
    t.integer "piece_head_id", null: false
    t.integer "company_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_ph_labels_on_company_id"
    t.index ["piece_head_id"], name: "index_ph_labels_on_piece_head_id"
  end

  create_table "piece_heads", id: :serial, force: :cascade do |t|
    t.integer "artist_credit_id"
    t.integer "season_id"
    t.string "title", null: false
    t.string "disambiguation"
    t.integer "position"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.bigint "wikidata_code"
    t.bigint "import_order_id"
    t.index "artist_credit_id, type, lower((title)::text), lower((disambiguation)::text)", name: "index_piece_heads_on_lower_title_disambiguation", unique: true
    t.index ["artist_credit_id"], name: "index_piece_heads_on_artist_credit_id"
    t.index ["import_order_id"], name: "index_piece_heads_on_import_order_id"
    t.index ["season_id"], name: "index_piece_heads_on_season_id"
  end

  create_table "piece_heads_tags", id: false, force: :cascade do |t|
    t.integer "piece_head_id", null: false
    t.integer "tag_id", null: false
    t.index ["piece_head_id"], name: "index_piece_heads_tags_on_piece_head_id"
    t.index ["tag_id"], name: "index_piece_heads_tags_on_tag_id"
  end

  create_table "piece_releases", force: :cascade do |t|
    t.string "accuracy"
    t.integer "milliseconds"
    t.bigint "import_order_id"
    t.bigint "piece_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import_order_id"], name: "index_piece_releases_on_import_order_id"
    t.index ["piece_id"], name: "index_piece_releases_on_piece_id"
  end

  create_table "piece_tracks", id: :serial, force: :cascade do |t|
    t.integer "piece_id", null: false
    t.integer "tr_format_kind_id"
    t.integer "milliseconds"
    t.text "accuracy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["piece_id"], name: "index_piece_tracks_on_piece_id"
    t.index ["tr_format_kind_id"], name: "index_piece_tracks_on_tr_format_kind_id"
  end

  create_table "pieces", id: :serial, force: :cascade do |t|
    t.integer "piece_head_id"
    t.integer "station_id"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.integer "date_mask", limit: 2
    t.bigint "artist_credit_id"
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.bigint "wikidata_code"
    t.string "title", null: false
    t.string "disambiguation"
    t.bigint "import_order_id"
    t.integer "milliseconds"
    t.text "accuracy"
    t.index ["artist_credit_id"], name: "index_pieces_on_artist_credit_id"
    t.index ["import_order_id"], name: "index_pieces_on_import_order_id"
    t.index ["piece_head_id"], name: "index_on_pieces_piece_head_id"
    t.index ["station_id"], name: "index_pieces_on_station_id"
  end

  create_table "pieces_tags", id: false, force: :cascade do |t|
    t.integer "piece_id", null: false
    t.integer "tag_id", null: false
    t.index ["piece_id"], name: "index_pieces_tags_on_piece_id"
    t.index ["tag_id"], name: "index_pieces_tags_on_tag_id"
  end

  create_table "pr_labels", id: :serial, force: :cascade do |t|
    t.integer "piece_id", null: false
    t.integer "company_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_pr_labels_on_company_id"
    t.index ["piece_id"], name: "index_pr_labels_on_piece_id"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.integer "value", limit: 2, null: false
    t.integer "user_id", null: false
    t.integer "artist_credit_id"
    t.integer "artist_id"
    t.integer "piece_head_id"
    t.integer "piece_id"
    t.integer "season_id"
    t.integer "serial_id"
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_ratings_on_artist_credit_id"
    t.index ["artist_id"], name: "index_ratings_on_artist_id"
    t.index ["piece_head_id"], name: "index_ratings_on_piece_head_id"
    t.index ["piece_id"], name: "index_ratings_on_piece_id"
    t.index ["season_id"], name: "index_ratings_on_season_id"
    t.index ["serial_id"], name: "index_ratings_on_serial_id"
    t.index ["station_id"], name: "index_ratings_on_station_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
    t.check_constraint "(value >= 0) AND (value <= 10)", name: "ratings_value_between_0_and_10"
  end

  create_table "release_catalog_numbers", force: :cascade do |t|
    t.text "code"
    t.bigint "release_company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code", "release_company_id"], name: "index_release_catalog_numbers_on_code_and_release_company_id", unique: true
    t.index ["release_company_id"], name: "index_release_catalog_numbers_on_release_company_id"
  end

  create_table "release_companies", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "company_role_id"
    t.bigint "release_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_release_companies_on_company_id"
    t.index ["company_role_id"], name: "index_release_companies_on_company_role_id"
    t.index ["release_id"], name: "index_release_companies_on_release_id"
  end

  create_table "release_copies", force: :cascade do |t|
    t.text "type"
    t.bigint "release_head_id"
    t.bigint "release_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "designation", null: false
    t.index ["designation", "user_id"], name: "index_release_copies_on_designation_and_user_id", unique: true
    t.index ["release_head_id"], name: "index_release_copies_on_release_head_id"
    t.index ["release_id"], name: "index_release_copies_on_release_id"
    t.index ["user_id"], name: "index_release_copies_on_user_id"
  end

  create_table "release_events", force: :cascade do |t|
    t.bigint "release_id", null: false
    t.bigint "area_id", null: false
    t.date "date"
    t.integer "date_mask", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_release_events_on_area_id"
    t.index ["release_id"], name: "index_release_events_on_release_id"
  end

  create_table "release_heads", force: :cascade do |t|
    t.string "disambiguation"
    t.string "title", null: false
    t.string "type"
    t.uuid "brainz_code"
    t.integer "imdb_code"
    t.integer "tmdb_code"
    t.integer "wikidata_code"
    t.bigint "artist_credit_id"
    t.bigint "import_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_release_heads_on_artist_credit_id"
    t.index ["import_order_id"], name: "index_release_heads_on_import_order_id"
  end

  create_table "release_images", force: :cascade do |t|
    t.boolean "front_cover", default: false, null: false
    t.boolean "back_cover", default: false, null: false
    t.string "note"
    t.bigint "release_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "import_order_id"
    t.bigint "image_id", null: false
    t.index ["image_id"], name: "index_release_images_on_image_id"
    t.index ["import_order_id"], name: "index_release_images_on_import_order_id"
    t.index ["release_id"], name: "index_release_images_on_release_id"
  end

  create_table "release_media", force: :cascade do |t|
    t.integer "position", limit: 2, null: false
    t.integer "quantity", limit: 2, null: false
    t.bigint "release_id", null: false
    t.bigint "medium_format_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medium_format_id"], name: "index_release_media_on_medium_format_id"
    t.index ["release_id"], name: "index_release_media_on_release_id"
  end

  create_table "release_subsets", force: :cascade do |t|
    t.integer "no", null: false
    t.string "title"
    t.bigint "release_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["release_id"], name: "index_release_subsets_on_release_id"
  end

  create_table "release_tracks", force: :cascade do |t|
    t.string "accuracy"
    t.integer "milliseconds"
    t.uuid "brainz_code"
    t.bigint "import_order_id"
    t.bigint "piece_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "release_subset_id", null: false
    t.integer "no", limit: 2, null: false
    t.index ["import_order_id"], name: "index_release_tracks_on_import_order_id"
    t.index ["piece_id"], name: "index_release_tracks_on_piece_id"
    t.index ["release_subset_id"], name: "index_release_tracks_on_release_subset_id"
  end

  create_table "releases", force: :cascade do |t|
    t.integer "barcode"
    t.date "date"
    t.integer "date_mask"
    t.string "title"
    t.string "type"
    t.string "version"
    t.uuid "brainz_code"
    t.integer "discogs_code"
    t.integer "imdb_code"
    t.integer "tmdb_code"
    t.integer "wikidata_code"
    t.bigint "artist_credit_id"
    t.bigint "import_order_id"
    t.bigint "release_head_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "area_id"
    t.bigint "language_id"
    t.bigint "script_id"
    t.index ["area_id"], name: "index_releases_on_area_id"
    t.index ["artist_credit_id"], name: "index_releases_on_artist_credit_id"
    t.index ["import_order_id"], name: "index_releases_on_import_order_id"
    t.index ["language_id"], name: "index_releases_on_language_id"
    t.index ["release_head_id"], name: "index_releases_on_release_head_id"
    t.index ["script_id"], name: "index_releases_on_script_id"
  end

  create_table "scripts", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso_code", null: false
    t.string "iso_number", limit: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons", id: :serial, force: :cascade do |t|
    t.integer "serial_id", null: false
    t.integer "position", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.bigint "wikidata_code"
    t.index ["position", "serial_id"], name: "index_seasons_on_position_and_serial_id", unique: true
  end

  create_table "seasons_tags", id: false, force: :cascade do |t|
    t.integer "season_id", null: false
    t.integer "tag_id", null: false
    t.index ["season_id"], name: "index_seasons_tags_on_season_id"
    t.index ["tag_id"], name: "index_seasons_tags_on_tag_id"
  end

  create_table "serials", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "disambiguation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.bigint "wikidata_code"
    t.index "lower((title)::text)", name: "index_serials_on_lower_title", unique: true, where: "(disambiguation IS NULL)"
    t.index "lower((title)::text), lower((disambiguation)::text)", name: "index_serials_on_lower_disambiguation_and_title", unique: true
  end

  create_table "serials_tags", id: false, force: :cascade do |t|
    t.integer "serial_id", null: false
    t.integer "tag_id", null: false
    t.index ["serial_id"], name: "index_serials_tags_on_serial_id"
    t.index ["tag_id"], name: "index_serials_tags_on_tag_id"
  end

  create_table "stations", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "disambiguation"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((disambiguation)::text), lower((name)::text)", name: "index_stations_on_lower_disambiguation_and_name", unique: true
    t.index "lower((name)::text)", name: "index_stations_on_lower_name", unique: true, where: "(disambiguation IS NULL)"
  end

  create_table "stations_tags", id: false, force: :cascade do |t|
    t.integer "station_id", null: false
    t.integer "tag_id", null: false
    t.index ["station_id"], name: "index_stations_tags_on_station_id"
    t.index ["tag_id"], name: "index_stations_tags_on_tag_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "importer", default: false
    t.boolean "curator", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "area_aliases", "areas"
  add_foreign_key "areas", "import_orders"
  add_foreign_key "artist_credits", "import_orders"
  add_foreign_key "artist_credits_tags", "artist_credits"
  add_foreign_key "artist_credits_tags", "tags"
  add_foreign_key "artists", "import_orders"
  add_foreign_key "artists_tags", "artists"
  add_foreign_key "artists_tags", "tags"
  add_foreign_key "companies", "areas"
  add_foreign_key "companies", "import_orders"
  add_foreign_key "image_tags_release_images", "image_tags"
  add_foreign_key "image_tags_release_images", "release_images"
  add_foreign_key "images", "import_orders"
  add_foreign_key "import_orders", "import_orders"
  add_foreign_key "import_orders", "import_queues"
  add_foreign_key "import_orders", "users"
  add_foreign_key "import_request_attempts", "import_requests"
  add_foreign_key "import_request_bodies", "import_requests"
  add_foreign_key "import_requests", "import_orders"
  add_foreign_key "iso3166_part1_countries", "areas"
  add_foreign_key "iso3166_part2_countries", "areas"
  add_foreign_key "iso3166_part3_countries", "areas"
  add_foreign_key "medium_formats", "import_orders"
  add_foreign_key "original_exemplars", "users"
  add_foreign_key "participants", "artist_credits", name: "participants_fk_artist_credits"
  add_foreign_key "participants", "artists", name: "participants_fk_artists"
  add_foreign_key "ph_labels", "companies"
  add_foreign_key "ph_labels", "piece_heads"
  add_foreign_key "piece_heads", "artist_credits", name: "piece_heads_fk_artist_credits"
  add_foreign_key "piece_heads", "import_orders"
  add_foreign_key "piece_heads", "seasons", name: "piece_heads_fk_seasons"
  add_foreign_key "piece_heads_tags", "piece_heads"
  add_foreign_key "piece_heads_tags", "tags"
  add_foreign_key "piece_releases", "import_orders"
  add_foreign_key "piece_releases", "pieces"
  add_foreign_key "piece_tracks", "pieces"
  add_foreign_key "pieces", "artist_credits"
  add_foreign_key "pieces", "import_orders"
  add_foreign_key "pieces", "piece_heads", name: "pieces_fk_piece_heads"
  add_foreign_key "pieces", "stations", name: "pieces_fk_stations"
  add_foreign_key "pieces_tags", "pieces"
  add_foreign_key "pieces_tags", "tags"
  add_foreign_key "pr_labels", "companies"
  add_foreign_key "pr_labels", "pieces"
  add_foreign_key "ratings", "artist_credits"
  add_foreign_key "ratings", "artists"
  add_foreign_key "ratings", "piece_heads"
  add_foreign_key "ratings", "pieces"
  add_foreign_key "ratings", "seasons"
  add_foreign_key "ratings", "serials"
  add_foreign_key "ratings", "stations"
  add_foreign_key "ratings", "users"
  add_foreign_key "release_catalog_numbers", "release_companies"
  add_foreign_key "release_companies", "companies"
  add_foreign_key "release_companies", "company_roles"
  add_foreign_key "release_companies", "releases"
  add_foreign_key "release_copies", "release_heads"
  add_foreign_key "release_copies", "releases"
  add_foreign_key "release_copies", "users"
  add_foreign_key "release_events", "areas"
  add_foreign_key "release_events", "releases"
  add_foreign_key "release_heads", "artist_credits"
  add_foreign_key "release_heads", "import_orders"
  add_foreign_key "release_images", "images"
  add_foreign_key "release_images", "import_orders"
  add_foreign_key "release_images", "releases"
  add_foreign_key "release_media", "medium_formats"
  add_foreign_key "release_media", "releases"
  add_foreign_key "release_subsets", "releases"
  add_foreign_key "release_tracks", "import_orders"
  add_foreign_key "release_tracks", "pieces"
  add_foreign_key "release_tracks", "release_subsets"
  add_foreign_key "releases", "areas"
  add_foreign_key "releases", "artist_credits"
  add_foreign_key "releases", "import_orders"
  add_foreign_key "releases", "languages"
  add_foreign_key "releases", "release_heads"
  add_foreign_key "releases", "scripts"
  add_foreign_key "seasons", "serials", name: "seasons_fk_seasons"
  add_foreign_key "seasons_tags", "seasons"
  add_foreign_key "seasons_tags", "tags"
  add_foreign_key "serials_tags", "serials"
  add_foreign_key "serials_tags", "tags"
  add_foreign_key "stations_tags", "stations"
  add_foreign_key "stations_tags", "tags"
end
