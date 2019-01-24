# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_24_044948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "artist_credits", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_id"
    t.bigint "data_import_id"
    t.index ["data_import_id"], name: "index_artist_credits_on_data_import_id"
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
    t.bigint "data_import_id"
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "wikidata_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.index ["brainz_code"], name: "index_on_artists_brainz_code", unique: true
    t.index ["data_import_id"], name: "index_artists_on_data_import_id"
    t.index ["discogs_code"], name: "index_on_artists_discogs_code", unique: true
    t.index ["wikidata_code"], name: "index_on_artists_wikidata_code", unique: true
  end

  create_table "artists_tags", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "tag_id", null: false
    t.index ["artist_id"], name: "index_artists_tags_on_artist_id"
    t.index ["tag_id"], name: "index_artists_tags_on_tag_id"
  end

  create_table "brainz_releases", force: :cascade do |t|
    t.uuid "mbid", null: false
    t.text "url", null: false
    t.xml "data", null: false
    t.integer "compilation_release_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "brainz_releases_url_key", unique: true
  end

  create_table "ch_companies", id: :serial, force: :cascade do |t|
    t.integer "compilation_head_id", null: false
    t.integer "company_id", null: false
    t.integer "company_role_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_ch_companies_on_company_id"
    t.index ["company_role_id"], name: "index_ch_companies_on_company_role_id"
    t.index ["compilation_head_id"], name: "index_ch_companies_on_compilation_head_id"
  end

  create_table "ch_credits", id: :serial, force: :cascade do |t|
    t.integer "artist_credit_id", null: false
    t.integer "compilation_head_id", null: false
    t.integer "job_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_ch_credits_on_artist_credit_id"
    t.index ["compilation_head_id"], name: "index_ch_credits_on_compilation_head_id"
    t.index ["job_id"], name: "index_ch_credits_on_job_id"
  end

  create_table "ch_labels", id: :serial, force: :cascade do |t|
    t.integer "compilation_head_id", null: false
    t.integer "company_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_ch_labels_on_company_id"
    t.index ["compilation_head_id"], name: "index_ch_labels_on_compilation_head_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "text", null: false
    t.integer "user_id", null: false
    t.integer "artist_credit_id"
    t.integer "artist_id"
    t.integer "compilation_head_id"
    t.integer "compilation_release_id"
    t.integer "piece_head_id"
    t.integer "piece_release_id"
    t.integer "repository_id"
    t.integer "season_id"
    t.integer "serial_id"
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_comments_on_artist_credit_id"
    t.index ["artist_id"], name: "index_comments_on_artist_id"
    t.index ["compilation_head_id"], name: "index_comments_on_compilation_head_id"
    t.index ["compilation_release_id"], name: "index_comments_on_compilation_release_id"
    t.index ["piece_head_id"], name: "index_comments_on_piece_head_id"
    t.index ["piece_release_id"], name: "index_comments_on_piece_release_id"
    t.index ["repository_id"], name: "index_comments_on_repository_id"
    t.index ["season_id"], name: "index_comments_on_season_id"
    t.index ["serial_id"], name: "index_comments_on_serial_id"
    t.index ["station_id"], name: "index_comments_on_station_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_companies_on_lower_name", unique: true
  end

  create_table "company_roles", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_company_roles_on_lower_name", unique: true
  end

  create_table "compilation_copies", id: :serial, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "user_id", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compilation_release_id"], name: "index_compilation_copies_on_compilation_release_id"
    t.index ["id", "compilation_release_id", "user_id"], name: "index_compilation_copies", unique: true
    t.index ["user_id"], name: "index_compilation_copies_on_user_id"
  end

  create_table "compilation_heads", id: :serial, force: :cascade do |t|
    t.integer "artist_credit_id"
    t.string "title", null: false
    t.string "disambiguation"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "data_import_id"
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "wikidata_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.index ["artist_credit_id"], name: "index_compilation_heads_on_artist_credit_id"
    t.index ["data_import_id"], name: "index_compilation_heads_on_data_import_id"
  end

  create_table "compilation_heads_countries", id: false, force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "compilation_head_id", null: false
    t.index ["compilation_head_id"], name: "index_compilation_heads_countries_on_compilation_head_id"
    t.index ["country_id", "compilation_head_id"], name: "index_phc_on_country_id_and_compilation_head_id", unique: true
    t.index ["country_id"], name: "index_compilation_heads_countries_on_country_id"
  end

  create_table "compilation_heads_tags", id: false, force: :cascade do |t|
    t.integer "compilation_head_id", null: false
    t.integer "tag_id", null: false
    t.index ["compilation_head_id"], name: "index_compilation_heads_tags_on_compilation_head_id"
    t.index ["tag_id"], name: "index_compilation_heads_tags_on_tag_id"
  end

  create_table "compilation_releases", id: :serial, force: :cascade do |t|
    t.integer "compilation_head_id", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.integer "date_mask", limit: 2
    t.citext "version"
    t.citext "title", null: false
    t.bigint "artist_credit_id"
    t.bigint "data_import_id"
    t.uuid "brainz_code"
    t.bigint "discogs_code"
    t.bigint "imdb_code"
    t.bigint "tmdb_code"
    t.bigint "wikidata_code"
    t.index ["artist_credit_id"], name: "index_compilation_releases_on_artist_credit_id"
    t.index ["brainz_code"], name: "index_on_compilation_releases_brainz_code", unique: true
    t.index ["compilation_head_id"], name: "compilation_releases_compilation_head_id_idx"
    t.index ["data_import_id"], name: "index_compilation_releases_on_data_import_id"
  end

  create_table "compilation_releases_countries", id: false, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "country_id", null: false
    t.index ["compilation_release_id", "country_id"], name: "index_compilation_releases_countries_no_and_ids", unique: true
  end

  create_table "compilation_releases_tags", id: false, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "tag_id", null: false
    t.index ["compilation_release_id"], name: "index_compilation_releases_tags_on_compilation_release_id"
    t.index ["tag_id"], name: "index_compilation_releases_tags_on_tag_id"
  end

  create_table "compilation_track_details", id: :serial, force: :cascade do |t|
    t.integer "track_id", null: false
    t.integer "trf_attribute_kind_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id", "position"], name: "index_compilation_track_details_on_track_id_and_position", unique: true
  end

  create_table "compilation_tracks", id: :serial, force: :cascade do |t|
    t.integer "piece_release_id", null: false
    t.integer "position"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "compilation_release_id"
    t.string "location"
    t.string "heading"
    t.integer "milliseconds"
    t.string "accuracy"
    t.string "side"
    t.integer "format_id"
    t.index ["compilation_release_id"], name: "index_compilation_tracks_on_compilation_release_id"
    t.index ["id", "compilation_release_id"], name: "compilation_tracks_id_and_compilation_release_id", unique: true
    t.index ["piece_release_id"], name: "index_compilation_tracks_on_piece_release_id"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_countries_on_lower_name", unique: true
  end

  create_table "countries_piece_heads", id: :serial, force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "piece_head_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id", "piece_head_id"], name: "index_countries_piece_heads_on_country_id_and_piece_head_id", unique: true
    t.index ["country_id"], name: "index_countries_piece_heads_on_country_id"
    t.index ["piece_head_id"], name: "index_countries_piece_heads_on_piece_head_id"
  end

  create_table "countries_piece_releases", id: false, force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "piece_release_id", null: false
    t.index ["country_id", "piece_release_id"], name: "index_cpr_on_country_id_and_piece_release_id", unique: true
    t.index ["country_id"], name: "index_countries_piece_releases_on_country_id"
    t.index ["piece_release_id"], name: "index_countries_piece_releases_on_piece_release_id"
  end

  create_table "cr_companies", id: :serial, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "company_role_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "compilation_release_id", null: false
    t.index ["company_id"], name: "index_cr_companies_on_company_id"
    t.index ["company_role_id"], name: "index_cr_companies_on_company_role_id"
    t.index ["compilation_release_id"], name: "index_cr_companies_on_compilation_release_id"
  end

  create_table "cr_credits", id: :serial, force: :cascade do |t|
    t.integer "artist_credit_id", null: false
    t.integer "compilation_release_id", null: false
    t.integer "job_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_cr_credits_on_artist_credit_id"
    t.index ["compilation_release_id"], name: "index_cr_credits_on_compilation_release_id"
    t.index ["job_id"], name: "index_cr_credits_on_job_id"
  end

  create_table "cr_format_details", id: :serial, force: :cascade do |t|
    t.integer "cr_format_id", null: false
    t.integer "position", null: false
    t.integer "format_detail_id"
    t.index ["cr_format_id", "position"], name: "cr_format_details_cr_format_id_position_idx", unique: true
  end

  create_table "cr_formats", id: :serial, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "position", null: false
    t.integer "quantity", null: false
    t.text "note"
    t.integer "format_id"
    t.index ["compilation_release_id", "position"], name: "cr_formats_compilation_release_id_position_idx", unique: true
  end

  create_table "cr_labels", id: :serial, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "company_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_cr_labels_on_company_id"
    t.index ["compilation_release_id"], name: "index_cr_labels_on_compilation_release_id"
  end

  create_table "ct_format_details", id: :serial, force: :cascade do |t|
    t.integer "compilation_track_id", null: false
    t.integer "position", null: false
    t.integer "format_detail_id"
    t.index ["compilation_track_id", "position"], name: "ct_format_details_compilation_track_id_position_idx", unique: true
  end

  create_table "data_imports", force: :cascade do |t|
    t.text "note", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "descriptions", id: :serial, force: :cascade do |t|
    t.text "text", null: false
    t.integer "user_id"
    t.integer "source_id"
    t.integer "artist_credit_id"
    t.integer "artist_id"
    t.integer "compilation_head_id"
    t.integer "compilation_release_id"
    t.integer "country_id"
    t.integer "piece_head_id"
    t.integer "piece_release_id"
    t.integer "season_id"
    t.integer "serial_id"
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_descriptions_on_artist_credit_id"
    t.index ["artist_id"], name: "index_descriptions_on_artist_id"
    t.index ["compilation_head_id"], name: "index_descriptions_on_compilation_head_id"
    t.index ["compilation_release_id"], name: "index_descriptions_on_compilation_release_id"
    t.index ["country_id"], name: "index_descriptions_on_country_id"
    t.index ["piece_head_id"], name: "index_descriptions_on_piece_head_id"
    t.index ["piece_release_id"], name: "index_descriptions_on_piece_release_id"
    t.index ["season_id"], name: "index_descriptions_on_season_id"
    t.index ["serial_id"], name: "index_descriptions_on_serial_id"
    t.index ["source_id"], name: "index_descriptions_on_source_id"
    t.index ["station_id"], name: "index_descriptions_on_station_id"
    t.index ["user_id"], name: "index_descriptions_on_user_id"
  end

  create_table "format_details", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.text "abbr"
    t.index "lower(name)", name: "format_details_lower_idx", unique: true
    t.index ["abbr"], name: "format_details_abbr_key", unique: true
  end

  create_table "formats", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.text "abbr"
    t.index "lower(name)", name: "formats_lower_idx", unique: true
    t.index ["abbr"], name: "formats_abbr_key", unique: true
  end

  create_table "heap_heads", force: :cascade do |t|
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
    t.index ["artist_credit_id"], name: "index_heap_heads_on_artist_credit_id"
    t.index ["import_order_id"], name: "index_heap_heads_on_import_order_id"
  end

  create_table "heaps", force: :cascade do |t|
    t.integer "barcode"
    t.date "date"
    t.integer "data_mask"
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
    t.bigint "heap_head_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_heaps_on_artist_credit_id"
    t.index ["heap_head_id"], name: "index_heaps_on_heap_head_id"
    t.index ["import_order_id"], name: "index_heaps_on_import_order_id"
  end

  create_table "import_orders", force: :cascade do |t|
    t.text "code", null: false
    t.text "kind", null: false
    t.text "state", null: false
    t.text "type", null: false
    t.text "uri"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requests_count"
    t.index ["user_id"], name: "index_import_orders_on_user_id"
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
    t.index ["import_order_id"], name: "index_import_requests_on_import_order_id"
  end

  create_table "jobs", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_jobs_on_lower_name", unique: true
  end

  create_table "original_exemplars", id: :serial, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "user_id", null: false
    t.text "disambiguation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compilation_release_id"], name: "index_original_exemplars_on_compilation_release_id"
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

  create_table "ph_companies", id: :serial, force: :cascade do |t|
    t.integer "piece_head_id", null: false
    t.integer "company_id", null: false
    t.integer "company_role_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_ph_companies_on_company_id"
    t.index ["company_role_id"], name: "index_ph_companies_on_company_role_id"
    t.index ["piece_head_id"], name: "index_ph_companies_on_piece_head_id"
  end

  create_table "ph_credits", id: :serial, force: :cascade do |t|
    t.integer "artist_credit_id", null: false
    t.integer "piece_head_id", null: false
    t.integer "job_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_ph_credits_on_artist_credit_id"
    t.index ["job_id"], name: "index_ph_credits_on_job_id"
    t.index ["piece_head_id"], name: "index_ph_credits_on_piece_head_id"
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
    t.index "artist_credit_id, type, lower((title)::text), lower((disambiguation)::text)", name: "index_piece_heads_on_lower_title_disambiguation", unique: true
    t.index ["artist_credit_id"], name: "index_piece_heads_on_artist_credit_id"
    t.index ["season_id"], name: "index_piece_heads_on_season_id"
  end

  create_table "piece_heads_tags", id: false, force: :cascade do |t|
    t.integer "piece_head_id", null: false
    t.integer "tag_id", null: false
    t.index ["piece_head_id"], name: "index_piece_heads_tags_on_piece_head_id"
    t.index ["tag_id"], name: "index_piece_heads_tags_on_tag_id"
  end

  create_table "piece_releases_tags", id: false, force: :cascade do |t|
    t.integer "piece_release_id", null: false
    t.integer "tag_id", null: false
    t.index ["piece_release_id"], name: "index_piece_releases_tags_on_piece_release_id"
    t.index ["tag_id"], name: "index_piece_releases_tags_on_tag_id"
  end

  create_table "piece_tracks", id: :serial, force: :cascade do |t|
    t.integer "piece_release_id", null: false
    t.integer "tr_format_kind_id"
    t.integer "milliseconds"
    t.text "accuracy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["piece_release_id"], name: "index_piece_tracks_on_piece_release_id"
    t.index ["tr_format_kind_id"], name: "index_piece_tracks_on_tr_format_kind_id"
  end

  create_table "pieces", id: :serial, force: :cascade do |t|
    t.integer "piece_head_id", null: false
    t.integer "station_id"
    t.string "version"
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
    t.index "piece_head_id, lower((version)::text)", name: "index_piece_releases_on_piece_head_id_and_lower_version", unique: true
    t.index ["artist_credit_id"], name: "index_pieces_on_artist_credit_id"
    t.index ["station_id"], name: "index_pieces_on_station_id"
  end

  create_table "pr_companies", id: :serial, force: :cascade do |t|
    t.integer "piece_release_id", null: false
    t.integer "company_id", null: false
    t.integer "company_role_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_pr_companies_on_company_id"
    t.index ["company_role_id"], name: "index_pr_companies_on_company_role_id"
    t.index ["piece_release_id"], name: "index_pr_companies_on_piece_release_id"
  end

  create_table "pr_credits", id: :serial, force: :cascade do |t|
    t.integer "artist_credit_id", null: false
    t.integer "piece_release_id", null: false
    t.integer "job_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_pr_credits_on_artist_credit_id"
    t.index ["job_id"], name: "index_pr_credits_on_job_id"
    t.index ["piece_release_id"], name: "index_pr_credits_on_piece_release_id"
  end

  create_table "pr_labels", id: :serial, force: :cascade do |t|
    t.integer "piece_release_id", null: false
    t.integer "company_id", null: false
    t.string "catalog_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_pr_labels_on_company_id"
    t.index ["piece_release_id"], name: "index_pr_labels_on_piece_release_id"
  end

  create_table "product_number_types", force: :cascade do |t|
    t.citext "name", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "product_number_types_name_key", unique: true
  end

  create_table "product_numbers", force: :cascade do |t|
    t.text "code", null: false
    t.text "disambiguation"
    t.integer "compilation_release_id", null: false
    t.bigint "product_number_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "compilation_release_id", "product_number_type_id"], name: "product_numbers_code_compilation_release_id_product_number__idx", unique: true, where: "(disambiguation IS NULL)"
    t.index ["code", "disambiguation", "compilation_release_id", "product_number_type_id"], name: "product_numbers_code_disambiguation_compilation_release_id__idx", unique: true, where: "(disambiguation IS NOT NULL)"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.integer "value", limit: 2, null: false
    t.integer "user_id", null: false
    t.integer "artist_credit_id"
    t.integer "artist_id"
    t.integer "compilation_head_id"
    t.integer "compilation_release_id"
    t.integer "piece_head_id"
    t.integer "piece_release_id"
    t.integer "season_id"
    t.integer "serial_id"
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_ratings_on_artist_credit_id"
    t.index ["artist_id"], name: "index_ratings_on_artist_id"
    t.index ["compilation_head_id"], name: "index_ratings_on_compilation_head_id"
    t.index ["compilation_release_id"], name: "index_ratings_on_compilation_release_id"
    t.index ["piece_head_id"], name: "index_ratings_on_piece_head_id"
    t.index ["piece_release_id"], name: "index_ratings_on_piece_release_id"
    t.index ["season_id"], name: "index_ratings_on_season_id"
    t.index ["serial_id"], name: "index_ratings_on_serial_id"
    t.index ["station_id"], name: "index_ratings_on_station_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "repositories", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "format_id"
    t.index ["id", "user_id"], name: "index_repositories_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_format_details", id: :serial, force: :cascade do |t|
    t.integer "repository_id", null: false
    t.integer "position", null: false
    t.integer "format_detail_id"
    t.index ["repository_id", "position"], name: "repository_format_details_repository_id_position_idx", unique: true
  end

  create_table "repository_positions", id: :serial, force: :cascade do |t|
    t.integer "compilation_track_id"
    t.integer "compilation_release_id"
    t.integer "piece_release_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "repository_id", null: false
    t.integer "user_id", null: false
    t.integer "compilation_copy_id"
    t.integer "piece_track_id"
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

  create_table "sources", id: :serial, force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "name", null: false
    t.index ["name"], name: "sources_name_idx", unique: true
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "artist_credits", "data_imports"
  add_foreign_key "artist_credits", "sources", name: "fk_artist_credits_source_id"
  add_foreign_key "artist_credits_tags", "artist_credits"
  add_foreign_key "artist_credits_tags", "tags"
  add_foreign_key "artists", "data_imports"
  add_foreign_key "artists_tags", "artists"
  add_foreign_key "artists_tags", "tags"
  add_foreign_key "brainz_releases", "compilation_releases", name: "brainz_releases_compilation_release_id_fkey"
  add_foreign_key "ch_companies", "companies"
  add_foreign_key "ch_companies", "company_roles"
  add_foreign_key "ch_companies", "compilation_heads"
  add_foreign_key "ch_credits", "artist_credits"
  add_foreign_key "ch_credits", "compilation_heads"
  add_foreign_key "ch_credits", "jobs"
  add_foreign_key "ch_labels", "companies"
  add_foreign_key "ch_labels", "compilation_heads"
  add_foreign_key "comments", "artist_credits"
  add_foreign_key "comments", "artists"
  add_foreign_key "comments", "compilation_heads"
  add_foreign_key "comments", "compilation_releases"
  add_foreign_key "comments", "piece_heads"
  add_foreign_key "comments", "pieces", column: "piece_release_id"
  add_foreign_key "comments", "repositories"
  add_foreign_key "comments", "seasons"
  add_foreign_key "comments", "serials"
  add_foreign_key "comments", "stations"
  add_foreign_key "comments", "users"
  add_foreign_key "compilation_copies", "compilation_releases"
  add_foreign_key "compilation_copies", "users"
  add_foreign_key "compilation_heads", "artist_credits"
  add_foreign_key "compilation_heads", "data_imports"
  add_foreign_key "compilation_heads_countries", "compilation_heads"
  add_foreign_key "compilation_heads_countries", "countries"
  add_foreign_key "compilation_heads_tags", "compilation_heads"
  add_foreign_key "compilation_heads_tags", "tags"
  add_foreign_key "compilation_releases", "artist_credits"
  add_foreign_key "compilation_releases", "compilation_heads"
  add_foreign_key "compilation_releases", "data_imports"
  add_foreign_key "compilation_releases_countries", "compilation_releases"
  add_foreign_key "compilation_releases_countries", "countries"
  add_foreign_key "compilation_releases_tags", "compilation_releases"
  add_foreign_key "compilation_releases_tags", "tags"
  add_foreign_key "compilation_track_details", "compilation_tracks", column: "track_id"
  add_foreign_key "compilation_tracks", "compilation_releases"
  add_foreign_key "compilation_tracks", "formats", name: "fk_compilation_tracks_format_id"
  add_foreign_key "compilation_tracks", "pieces", column: "piece_release_id"
  add_foreign_key "countries_piece_heads", "countries"
  add_foreign_key "countries_piece_heads", "piece_heads"
  add_foreign_key "countries_piece_releases", "countries"
  add_foreign_key "countries_piece_releases", "pieces", column: "piece_release_id"
  add_foreign_key "cr_companies", "companies"
  add_foreign_key "cr_companies", "company_roles"
  add_foreign_key "cr_companies", "compilation_releases"
  add_foreign_key "cr_credits", "artist_credits"
  add_foreign_key "cr_credits", "compilation_releases"
  add_foreign_key "cr_credits", "jobs"
  add_foreign_key "cr_format_details", "cr_formats", name: "cr_format_details_cr_format_id_fkey"
  add_foreign_key "cr_format_details", "format_details", name: "fk_cr_format_details_format_detail_id"
  add_foreign_key "cr_formats", "compilation_releases", name: "cr_formats_compilation_release_id_fkey"
  add_foreign_key "cr_formats", "formats", name: "fk_cr_formats_format_id"
  add_foreign_key "cr_labels", "companies"
  add_foreign_key "cr_labels", "compilation_releases"
  add_foreign_key "ct_format_details", "compilation_tracks", name: "ct_format_details_compilation_track_id_fkey"
  add_foreign_key "ct_format_details", "format_details", name: "fk_ct_format_details_format_detail_id"
  add_foreign_key "descriptions", "artist_credits"
  add_foreign_key "descriptions", "artists"
  add_foreign_key "descriptions", "compilation_heads"
  add_foreign_key "descriptions", "compilation_releases"
  add_foreign_key "descriptions", "countries"
  add_foreign_key "descriptions", "piece_heads"
  add_foreign_key "descriptions", "pieces", column: "piece_release_id"
  add_foreign_key "descriptions", "seasons"
  add_foreign_key "descriptions", "serials"
  add_foreign_key "descriptions", "sources"
  add_foreign_key "descriptions", "stations"
  add_foreign_key "descriptions", "users"
  add_foreign_key "heap_heads", "artist_credits"
  add_foreign_key "heap_heads", "import_orders"
  add_foreign_key "heaps", "artist_credits"
  add_foreign_key "heaps", "heap_heads"
  add_foreign_key "heaps", "import_orders"
  add_foreign_key "import_orders", "users"
  add_foreign_key "import_request_attempts", "import_requests"
  add_foreign_key "import_request_bodies", "import_requests"
  add_foreign_key "import_requests", "import_orders"
  add_foreign_key "original_exemplars", "compilation_releases"
  add_foreign_key "original_exemplars", "users"
  add_foreign_key "participants", "artist_credits", name: "participants_fk_artist_credits"
  add_foreign_key "participants", "artists", name: "participants_fk_artists"
  add_foreign_key "ph_companies", "companies"
  add_foreign_key "ph_companies", "company_roles"
  add_foreign_key "ph_companies", "piece_heads"
  add_foreign_key "ph_credits", "artist_credits"
  add_foreign_key "ph_credits", "jobs"
  add_foreign_key "ph_credits", "piece_heads"
  add_foreign_key "ph_labels", "companies"
  add_foreign_key "ph_labels", "piece_heads"
  add_foreign_key "piece_heads", "artist_credits", name: "piece_heads_fk_artist_credits"
  add_foreign_key "piece_heads", "seasons", name: "piece_heads_fk_seasons"
  add_foreign_key "piece_heads_tags", "piece_heads"
  add_foreign_key "piece_heads_tags", "tags"
  add_foreign_key "piece_releases_tags", "pieces", column: "piece_release_id"
  add_foreign_key "piece_releases_tags", "tags"
  add_foreign_key "piece_tracks", "pieces", column: "piece_release_id"
  add_foreign_key "pieces", "artist_credits"
  add_foreign_key "pieces", "piece_heads", name: "pieces_fk_piece_heads"
  add_foreign_key "pieces", "stations", name: "pieces_fk_stations"
  add_foreign_key "pr_companies", "companies"
  add_foreign_key "pr_companies", "company_roles"
  add_foreign_key "pr_companies", "pieces", column: "piece_release_id"
  add_foreign_key "pr_credits", "artist_credits"
  add_foreign_key "pr_credits", "jobs"
  add_foreign_key "pr_credits", "pieces", column: "piece_release_id"
  add_foreign_key "pr_labels", "companies"
  add_foreign_key "pr_labels", "pieces", column: "piece_release_id"
  add_foreign_key "product_numbers", "compilation_releases", name: "product_numbers_compilation_release_id_fkey"
  add_foreign_key "product_numbers", "product_number_types", name: "product_numbers_product_number_type_id_fkey"
  add_foreign_key "ratings", "artist_credits"
  add_foreign_key "ratings", "artists"
  add_foreign_key "ratings", "compilation_heads"
  add_foreign_key "ratings", "compilation_releases"
  add_foreign_key "ratings", "piece_heads"
  add_foreign_key "ratings", "pieces", column: "piece_release_id"
  add_foreign_key "ratings", "seasons"
  add_foreign_key "ratings", "serials"
  add_foreign_key "ratings", "stations"
  add_foreign_key "ratings", "users"
  add_foreign_key "repositories", "formats", name: "fk_repositories_format_id"
  add_foreign_key "repositories", "users"
  add_foreign_key "repository_format_details", "format_details", name: "fk_repository_format_details_format_detail_id"
  add_foreign_key "repository_format_details", "repositories", name: "repository_format_details_repository_id_fkey"
  add_foreign_key "repository_positions", "compilation_copies", name: "fk_repository_positions_compilation_copies"
  add_foreign_key "repository_positions", "compilation_tracks", name: "repository_positions_compilation_track_id_fkey"
  add_foreign_key "repository_positions", "piece_tracks", name: "fk_repository_positions_piece_tracks"
  add_foreign_key "repository_positions", "pieces", column: "piece_release_id", name: "repository_positions_piece_release_id_fkey"
  add_foreign_key "repository_positions", "repositories", name: "fk_repository_position_repository"
  add_foreign_key "repository_positions", "users", name: "fk_repository_position_user"
  add_foreign_key "seasons", "serials", name: "seasons_fk_seasons"
  add_foreign_key "seasons_tags", "seasons"
  add_foreign_key "seasons_tags", "tags"
  add_foreign_key "serials_tags", "serials"
  add_foreign_key "serials_tags", "tags"
  add_foreign_key "stations_tags", "stations"
  add_foreign_key "stations_tags", "tags"
end
