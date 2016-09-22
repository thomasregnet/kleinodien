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

ActiveRecord::Schema.define(version: 20160922084803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_credits", force: :cascade do |t|
    t.string   "name",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "data_supplier_id"
    t.index "lower((name)::text)", name: "index_artist_credits_on_lower_name", unique: true, where: "(data_supplier_id IS NULL)", using: :btree
    t.index ["data_supplier_id"], name: "index_artist_credits_on_data_supplier_id", using: :btree
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "disambiguation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "source_name"
    t.string   "source_ident"
    t.index "lower((name)::text)", name: "index_artists_on_lower_name", unique: true, where: "((disambiguation IS NULL) AND (source_ident IS NULL))", using: :btree
    t.index "lower((name)::text), lower((disambiguation)::text)", name: "index_artists_on_lower_disambiguation_and_name", unique: true, where: "(source_ident IS NULL)", using: :btree
  end

  create_table "ch_companies", force: :cascade do |t|
    t.integer  "compilation_head_id", null: false
    t.integer  "company_id",          null: false
    t.integer  "company_role_id",     null: false
    t.string   "catalog_no"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["company_id"], name: "index_ch_companies_on_company_id", using: :btree
    t.index ["company_role_id"], name: "index_ch_companies_on_company_role_id", using: :btree
    t.index ["compilation_head_id"], name: "index_ch_companies_on_compilation_head_id", using: :btree
  end

  create_table "ch_credits", force: :cascade do |t|
    t.integer  "artist_credit_id",    null: false
    t.integer  "compilation_head_id", null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["artist_credit_id"], name: "index_ch_credits_on_artist_credit_id", using: :btree
    t.index ["compilation_head_id"], name: "index_ch_credits_on_compilation_head_id", using: :btree
    t.index ["job_id"], name: "index_ch_credits_on_job_id", using: :btree
  end

  create_table "ch_labels", force: :cascade do |t|
    t.integer  "compilation_head_id", null: false
    t.integer  "company_id",          null: false
    t.string   "catalog_no"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["company_id"], name: "index_ch_labels_on_company_id", using: :btree
    t.index ["compilation_head_id"], name: "index_ch_labels_on_compilation_head_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_companies_on_lower_name", unique: true, using: :btree
  end

  create_table "company_roles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_company_roles_on_lower_name", unique: true, using: :btree
  end

  create_table "compilation_heads", force: :cascade do |t|
    t.integer  "artist_credit_id"
    t.string   "title",            null: false
    t.string   "disambiguation"
    t.string   "type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "source_name"
    t.string   "source_ident"
    t.index "type, lower((title)::text)", name: "index_compilation_heads_on_lower_title", unique: true, where: "((disambiguation IS NULL) AND (source_ident IS NULL))", using: :btree
    t.index "type, lower((title)::text), lower((disambiguation)::text)", name: "index_compilation_heads_on_lower_title_disambiguation", unique: true, where: "(source_ident IS NULL)", using: :btree
    t.index ["artist_credit_id"], name: "index_compilation_heads_on_artist_credit_id", using: :btree
  end

  create_table "compilation_heads_countries", id: false, force: :cascade do |t|
    t.integer "country_id",          null: false
    t.integer "compilation_head_id", null: false
    t.index ["compilation_head_id"], name: "index_compilation_heads_countries_on_compilation_head_id", using: :btree
    t.index ["country_id", "compilation_head_id"], name: "index_phc_on_country_id_and_compilation_head_id", unique: true, using: :btree
    t.index ["country_id"], name: "index_compilation_heads_countries_on_country_id", using: :btree
  end

  create_table "compilation_identifiers", force: :cascade do |t|
    t.integer  "compilation_release_id", null: false
    t.integer  "identifier_type_id",     null: false
    t.string   "code",                   null: false
    t.string   "disambiguation"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index "compilation_release_id, identifier_type_id, code, lower((disambiguation)::text)", name: "index_compilation_identifiers_on_code_disambiguation", unique: true, using: :btree
    t.index ["compilation_release_id", "identifier_type_id", "code"], name: "index_compilation_identifiers_on_code", unique: true, where: "(disambiguation IS NULL)", using: :btree
  end

  create_table "compilation_releases", force: :cascade do |t|
    t.integer  "compilation_head_id", null: false
    t.string   "version"
    t.string   "type",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.date     "date"
    t.integer  "date_mask"
    t.string   "source_name"
    t.string   "source_ident"
    t.index "compilation_head_id, lower((version)::text)", name: "index_compilation_releases_on_compilation_head_id_lower_version", unique: true, using: :btree
    t.index "type, compilation_head_id, lower((version)::text)", name: "index_compilation_releases_on_lower_version", unique: true, where: "(source_ident IS NULL)", using: :btree
    t.index ["compilation_head_id"], name: "index_compilation_releases_on_compilation_head_id", unique: true, using: :btree
  end

  create_table "compilation_releases_countries", id: false, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "country_id",             null: false
    t.index ["compilation_release_id", "country_id"], name: "index_compilation_releases_countries_no_and_ids", unique: true, using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_countries_on_lower_name", unique: true, using: :btree
  end

  create_table "countries_piece_heads", force: :cascade do |t|
    t.integer  "country_id",    null: false
    t.integer  "piece_head_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["country_id", "piece_head_id"], name: "index_countries_piece_heads_on_country_id_and_piece_head_id", unique: true, using: :btree
    t.index ["country_id"], name: "index_countries_piece_heads_on_country_id", using: :btree
    t.index ["piece_head_id"], name: "index_countries_piece_heads_on_piece_head_id", using: :btree
  end

  create_table "countries_piece_releases", id: false, force: :cascade do |t|
    t.integer "country_id",       null: false
    t.integer "piece_release_id", null: false
    t.index ["country_id", "piece_release_id"], name: "index_cpr_on_country_id_and_piece_release_id", unique: true, using: :btree
    t.index ["country_id"], name: "index_countries_piece_releases_on_country_id", using: :btree
    t.index ["piece_release_id"], name: "index_countries_piece_releases_on_piece_release_id", using: :btree
  end

  create_table "cr_companies", force: :cascade do |t|
    t.integer  "company_id",             null: false
    t.integer  "company_role_id",        null: false
    t.string   "catalog_no"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "compilation_release_id", null: false
    t.index ["company_id"], name: "index_cr_companies_on_company_id", using: :btree
    t.index ["company_role_id"], name: "index_cr_companies_on_company_role_id", using: :btree
    t.index ["compilation_release_id"], name: "index_cr_companies_on_compilation_release_id", using: :btree
  end

  create_table "cr_credits", force: :cascade do |t|
    t.integer  "artist_credit_id",       null: false
    t.integer  "compilation_release_id", null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["artist_credit_id"], name: "index_cr_credits_on_artist_credit_id", using: :btree
    t.index ["compilation_release_id"], name: "index_cr_credits_on_compilation_release_id", using: :btree
    t.index ["job_id"], name: "index_cr_credits_on_job_id", using: :btree
  end

  create_table "cr_format_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_cr_format_kinds_on_lower_name", unique: true, using: :btree
  end

  create_table "cr_formats", force: :cascade do |t|
    t.integer  "compilation_release_id", null: false
    t.integer  "cr_format_kind_id",      null: false
    t.integer  "quantity",               null: false
    t.integer  "no",                     null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "note"
    t.index ["compilation_release_id", "no"], name: "index_cr_formats_on_compilation_release_id_and_no", unique: true, using: :btree
    t.index ["cr_format_kind_id"], name: "index_cr_formats_on_cr_format_kind_id", using: :btree
  end

  create_table "cr_labels", force: :cascade do |t|
    t.integer  "compilation_release_id", null: false
    t.integer  "company_id",             null: false
    t.string   "catalog_no"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["company_id"], name: "index_cr_labels_on_company_id", using: :btree
    t.index ["compilation_release_id"], name: "index_cr_labels_on_compilation_release_id", using: :btree
  end

  create_table "crf_detail_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_crf_attribute_kinds_on_lower_name", unique: true, using: :btree
  end

  create_table "crf_details", force: :cascade do |t|
    t.integer  "cr_format_id",       null: false
    t.integer  "crf_detail_kind_id", null: false
    t.integer  "no",                 null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["cr_format_id", "no"], name: "index_crf_details_on_cr_format_id_and_no", unique: true, using: :btree
    t.index ["crf_detail_kind_id"], name: "index_crf_details_on_crf_detail_kind_id", using: :btree
  end

  create_table "data_suppliers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_data_sources_on_lower_name", unique: true, using: :btree
    t.index "lower((name)::text)", name: "index_data_suppliers_on_lower_name", unique: true, using: :btree
  end

  create_table "identifier_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_identifier_types_on_lower_name", unique: true, using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_jobs_on_lower_name", unique: true, using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "no",               null: false
    t.string   "join_phrase"
    t.integer  "artist_id",        null: false
    t.integer  "artist_credit_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["artist_id"], name: "index_participants_on_artist_id", using: :btree
    t.index ["no", "artist_credit_id"], name: "index_participants_on_artist_credit_id_and_no", unique: true, using: :btree
  end

  create_table "ph_companies", force: :cascade do |t|
    t.integer  "piece_head_id",   null: false
    t.integer  "company_id",      null: false
    t.integer  "company_role_id", null: false
    t.string   "catalog_no"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["company_id"], name: "index_ph_companies_on_company_id", using: :btree
    t.index ["company_role_id"], name: "index_ph_companies_on_company_role_id", using: :btree
    t.index ["piece_head_id"], name: "index_ph_companies_on_piece_head_id", using: :btree
  end

  create_table "ph_credits", force: :cascade do |t|
    t.integer  "artist_credit_id", null: false
    t.integer  "piece_head_id",    null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["artist_credit_id"], name: "index_ph_credits_on_artist_credit_id", using: :btree
    t.index ["job_id"], name: "index_ph_credits_on_job_id", using: :btree
    t.index ["piece_head_id"], name: "index_ph_credits_on_piece_head_id", using: :btree
  end

  create_table "ph_labels", force: :cascade do |t|
    t.integer  "piece_head_id", null: false
    t.integer  "company_id",    null: false
    t.string   "catalog_no"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["company_id"], name: "index_ph_labels_on_company_id", using: :btree
    t.index ["piece_head_id"], name: "index_ph_labels_on_piece_head_id", using: :btree
  end

  create_table "piece_heads", force: :cascade do |t|
    t.integer  "artist_credit_id"
    t.integer  "season_id"
    t.string   "title",            null: false
    t.string   "disambiguation"
    t.integer  "no"
    t.string   "type",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "reference_id"
    t.index "artist_credit_id, type, lower((title)::text)", name: "index_piece_heads_on_lower_title", unique: true, where: "((disambiguation IS NULL) AND (reference_id IS NULL))", using: :btree
    t.index "artist_credit_id, type, lower((title)::text), lower((disambiguation)::text)", name: "index_piece_heads_on_lower_title_disambiguation", unique: true, using: :btree
    t.index ["artist_credit_id"], name: "index_piece_heads_on_artist_credit_id", using: :btree
    t.index ["reference_id"], name: "index_piece_heads_on_reference_id", using: :btree
    t.index ["reference_id"], name: "index_piece_heads_reference_id", unique: true, where: "(reference_id IS NOT NULL)", using: :btree
    t.index ["season_id"], name: "index_piece_heads_on_season_id", using: :btree
  end

  create_table "piece_heads_references", id: false, force: :cascade do |t|
    t.integer "piece_head_id"
    t.integer "reference_id"
    t.index ["piece_head_id"], name: "index_piece_heads_references_on_piece_head_id", using: :btree
    t.index ["reference_id"], name: "index_piece_heads_references_on_reference_id", using: :btree
  end

  create_table "piece_releases", force: :cascade do |t|
    t.integer  "piece_head_id", null: false
    t.integer  "station_id"
    t.string   "version"
    t.string   "type",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "date"
    t.integer  "date_mask"
    t.integer  "reference_id"
    t.index "piece_head_id, lower((version)::text)", name: "index_piece_releases_on_piece_head_id_and_lower_version", unique: true, using: :btree
    t.index ["piece_head_id"], name: "index_piece_releases_on_unique_piece_head_id", unique: true, where: "((version IS NULL) AND (reference_id IS NULL))", using: :btree
    t.index ["reference_id"], name: "index_piece_releases_on_reference_id", using: :btree
    t.index ["reference_id"], name: "index_piece_releases_reference_id", unique: true, where: "(reference_id IS NOT NULL)", using: :btree
    t.index ["station_id"], name: "index_piece_releases_on_station_id", using: :btree
  end

  create_table "piece_releases_references", id: false, force: :cascade do |t|
    t.integer "piece_release_id"
    t.integer "reference_id"
    t.index ["piece_release_id"], name: "index_piece_releases_references_on_piece_release_id", using: :btree
    t.index ["reference_id"], name: "index_piece_releases_references_on_reference_id", using: :btree
  end

  create_table "pr_companies", force: :cascade do |t|
    t.integer  "piece_release_id", null: false
    t.integer  "company_id",       null: false
    t.integer  "company_role_id",  null: false
    t.string   "catalog_no"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["company_id"], name: "index_pr_companies_on_company_id", using: :btree
    t.index ["company_role_id"], name: "index_pr_companies_on_company_role_id", using: :btree
    t.index ["piece_release_id"], name: "index_pr_companies_on_piece_release_id", using: :btree
  end

  create_table "pr_credits", force: :cascade do |t|
    t.integer  "artist_credit_id", null: false
    t.integer  "piece_release_id", null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["artist_credit_id"], name: "index_pr_credits_on_artist_credit_id", using: :btree
    t.index ["job_id"], name: "index_pr_credits_on_job_id", using: :btree
    t.index ["piece_release_id"], name: "index_pr_credits_on_piece_release_id", using: :btree
  end

  create_table "pr_labels", force: :cascade do |t|
    t.integer  "piece_release_id", null: false
    t.integer  "company_id",       null: false
    t.string   "catalog_no"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["company_id"], name: "index_pr_labels_on_company_id", using: :btree
    t.index ["piece_release_id"], name: "index_pr_labels_on_piece_release_id", using: :btree
  end

  create_table "references", force: :cascade do |t|
    t.integer  "data_supplier_id", null: false
    t.string   "identifier",       null: false
    t.string   "type",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["data_supplier_id", "identifier", "type"], name: "index_src_id_on_data_src_ident_type", unique: true, using: :btree
    t.index ["data_supplier_id"], name: "index_references_on_data_supplier_id", using: :btree
  end

  create_table "seasons", force: :cascade do |t|
    t.integer  "serial_id",  null: false
    t.integer  "no",         null: false
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["no", "serial_id"], name: "index_seasons_on_no_and_serial_id", unique: true, using: :btree
  end

  create_table "section_formats", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr",       null: false
    t.string   "note"
    t.integer  "rpm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "serials", force: :cascade do |t|
    t.string   "title",          null: false
    t.string   "disambiguation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "type",           null: false
    t.index "lower((title)::text)", name: "index_serials_on_lower_title", unique: true, where: "(disambiguation IS NULL)", using: :btree
    t.index "lower((title)::text), lower((disambiguation)::text)", name: "index_serials_on_lower_disambiguation_and_title", unique: true, using: :btree
  end

  create_table "sources", primary_key: "name", id: :string, force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "disambiguation"
    t.string   "type",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index "lower((disambiguation)::text), lower((name)::text)", name: "index_stations_on_lower_disambiguation_and_name", unique: true, using: :btree
    t.index "lower((name)::text)", name: "index_stations_on_lower_name", unique: true, where: "(disambiguation IS NULL)", using: :btree
  end

  create_table "tr_format_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_tr_format_kinds_on_lower_name", unique: true, using: :btree
  end

  create_table "track_detail_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_trf_attribute_kinds_on_lower_name", unique: true, using: :btree
  end

  create_table "track_details", force: :cascade do |t|
    t.integer  "track_id",              null: false
    t.integer  "trf_attribute_kind_id", null: false
    t.integer  "no",                    null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["track_id", "no"], name: "index_track_details_on_track_id_and_no", unique: true, using: :btree
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "piece_release_id",       null: false
    t.integer  "no"
    t.string   "path"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "compilation_release_id"
    t.string   "position"
    t.string   "heading"
    t.integer  "tr_format_kind_id"
    t.integer  "milliseconds"
    t.string   "accuracy"
    t.string   "side"
    t.index ["compilation_release_id"], name: "index_tracks_on_compilation_release_id", using: :btree
    t.index ["piece_release_id"], name: "index_tracks_on_piece_release_id", using: :btree
    t.index ["tr_format_kind_id"], name: "index_tracks_on_tr_format_kind_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "artist_credits", "data_suppliers"
  add_foreign_key "artists", "sources", column: "source_name", primary_key: "name"
  add_foreign_key "ch_companies", "companies"
  add_foreign_key "ch_companies", "company_roles"
  add_foreign_key "ch_companies", "compilation_heads"
  add_foreign_key "ch_credits", "artist_credits"
  add_foreign_key "ch_credits", "compilation_heads"
  add_foreign_key "ch_credits", "jobs"
  add_foreign_key "ch_labels", "companies"
  add_foreign_key "ch_labels", "compilation_heads"
  add_foreign_key "compilation_heads", "artist_credits"
  add_foreign_key "compilation_heads", "sources", column: "source_name", primary_key: "name"
  add_foreign_key "compilation_heads_countries", "compilation_heads"
  add_foreign_key "compilation_heads_countries", "countries"
  add_foreign_key "compilation_identifiers", "compilation_releases"
  add_foreign_key "compilation_identifiers", "identifier_types"
  add_foreign_key "compilation_releases", "compilation_heads"
  add_foreign_key "compilation_releases", "sources", column: "source_name", primary_key: "name"
  add_foreign_key "compilation_releases_countries", "compilation_releases"
  add_foreign_key "compilation_releases_countries", "countries"
  add_foreign_key "countries_piece_heads", "countries"
  add_foreign_key "countries_piece_heads", "piece_heads"
  add_foreign_key "countries_piece_releases", "countries"
  add_foreign_key "countries_piece_releases", "piece_releases"
  add_foreign_key "cr_companies", "companies"
  add_foreign_key "cr_companies", "company_roles"
  add_foreign_key "cr_companies", "compilation_releases"
  add_foreign_key "cr_credits", "artist_credits"
  add_foreign_key "cr_credits", "compilation_releases"
  add_foreign_key "cr_credits", "jobs"
  add_foreign_key "cr_formats", "compilation_releases"
  add_foreign_key "cr_formats", "cr_format_kinds"
  add_foreign_key "cr_labels", "companies"
  add_foreign_key "cr_labels", "compilation_releases"
  add_foreign_key "crf_details", "cr_formats"
  add_foreign_key "crf_details", "crf_detail_kinds"
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
  add_foreign_key "piece_heads", "\"references\"", column: "reference_id"
  add_foreign_key "piece_heads", "artist_credits", name: "piece_heads_fk_artist_credits"
  add_foreign_key "piece_heads", "seasons", name: "piece_heads_fk_seasons"
  add_foreign_key "piece_heads_references", "\"references\"", column: "reference_id"
  add_foreign_key "piece_heads_references", "piece_heads"
  add_foreign_key "piece_releases", "\"references\"", column: "reference_id"
  add_foreign_key "piece_releases", "piece_heads", name: "pieces_fk_piece_heads"
  add_foreign_key "piece_releases", "stations", name: "pieces_fk_stations"
  add_foreign_key "piece_releases_references", "\"references\"", column: "reference_id"
  add_foreign_key "piece_releases_references", "piece_releases"
  add_foreign_key "pr_companies", "companies"
  add_foreign_key "pr_companies", "company_roles"
  add_foreign_key "pr_companies", "piece_releases"
  add_foreign_key "pr_credits", "artist_credits"
  add_foreign_key "pr_credits", "jobs"
  add_foreign_key "pr_credits", "piece_releases"
  add_foreign_key "pr_labels", "companies"
  add_foreign_key "pr_labels", "piece_releases"
  add_foreign_key "references", "data_suppliers"
  add_foreign_key "references", "data_suppliers"
  add_foreign_key "seasons", "serials", name: "seasons_fk_seasons"
  add_foreign_key "track_details", "tracks"
  add_foreign_key "tracks", "compilation_releases"
  add_foreign_key "tracks", "piece_releases"
  add_foreign_key "tracks", "tr_format_kinds"
end
