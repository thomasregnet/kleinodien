# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151019185121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_credits", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "disambiguation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ch_credits", force: :cascade do |t|
    t.integer  "artist_credit_id",    null: false
    t.integer  "compilation_head_id", null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "ch_credits", ["artist_credit_id"], name: "index_ch_credits_on_artist_credit_id", using: :btree
  add_index "ch_credits", ["compilation_head_id"], name: "index_ch_credits_on_compilation_head_id", using: :btree
  add_index "ch_credits", ["job_id"], name: "index_ch_credits_on_job_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_roles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compilation_heads", force: :cascade do |t|
    t.integer  "artist_credit_id"
    t.string   "title",            null: false
    t.string   "disambiguation"
    t.string   "type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "compilation_heads", ["type"], name: "index_compilation_heads_on_lower_title", unique: true, where: "(disambiguation IS NULL)", using: :btree
  add_index "compilation_heads", ["type"], name: "index_compilation_heads_on_lower_title_disambiguation", unique: true, using: :btree

  create_table "compilation_identifiers", force: :cascade do |t|
    t.integer  "compilation_release_id", null: false
    t.integer  "identifier_type_id",     null: false
    t.string   "code",                   null: false
    t.string   "disambiguation"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "compilation_identifiers", ["compilation_release_id", "identifier_type_id", "code"], name: "index_compilation_identifiers_on_code", unique: true, where: "(disambiguation IS NULL)", using: :btree
  add_index "compilation_identifiers", ["compilation_release_id", "identifier_type_id", "code"], name: "index_compilation_identifiers_on_code_disambiguation", unique: true, using: :btree

  create_table "compilation_releases", force: :cascade do |t|
    t.integer  "compilation_head_id", null: false
    t.string   "version"
    t.string   "type",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.date     "date"
    t.integer  "date_mask"
  end

  add_index "compilation_releases", ["compilation_head_id"], name: "index_compilation_releases_on_compilation_head_id", unique: true, using: :btree
  add_index "compilation_releases", ["compilation_head_id"], name: "index_compilation_releases_on_compilation_head_id_lower_version", unique: true, using: :btree

  create_table "compilation_releases_countries", id: false, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "country_id",             null: false
  end

  add_index "compilation_releases_countries", ["compilation_release_id", "country_id"], name: "index_compilation_releases_countries_no_and_ids", unique: true, using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries_compilation_heads", id: false, force: :cascade do |t|
    t.integer "country_id",          null: false
    t.integer "compilation_head_id", null: false
  end

  add_index "countries_compilation_heads", ["compilation_head_id"], name: "index_countries_compilation_heads_on_compilation_head_id", using: :btree
  add_index "countries_compilation_heads", ["country_id", "compilation_head_id"], name: "index_cph_on_country_id_and_compilation_head_id", unique: true, using: :btree
  add_index "countries_compilation_heads", ["country_id"], name: "index_countries_compilation_heads_on_country_id", using: :btree

  create_table "countries_piece_heads", force: :cascade do |t|
    t.integer  "country_id",    null: false
    t.integer  "piece_head_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "countries_piece_heads", ["country_id", "piece_head_id"], name: "index_countries_piece_heads_on_country_id_and_piece_head_id", unique: true, using: :btree
  add_index "countries_piece_heads", ["country_id"], name: "index_countries_piece_heads_on_country_id", using: :btree
  add_index "countries_piece_heads", ["piece_head_id"], name: "index_countries_piece_heads_on_piece_head_id", using: :btree

  create_table "countries_piece_releases", id: false, force: :cascade do |t|
    t.integer "country_id",       null: false
    t.integer "piece_release_id", null: false
  end

  add_index "countries_piece_releases", ["country_id", "piece_release_id"], name: "index_cpr_on_country_id_and_piece_release_id", unique: true, using: :btree
  add_index "countries_piece_releases", ["country_id"], name: "index_countries_piece_releases_on_country_id", using: :btree
  add_index "countries_piece_releases", ["piece_release_id"], name: "index_countries_piece_releases_on_piece_release_id", using: :btree

  create_table "cr_companies", force: :cascade do |t|
    t.integer  "company_id",             null: false
    t.integer  "company_role_id",        null: false
    t.string   "catalog_no"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "compilation_release_id", null: false
  end

  create_table "cr_credits", force: :cascade do |t|
    t.integer  "artist_credit_id",       null: false
    t.integer  "compilation_release_id", null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cr_credits", ["artist_credit_id"], name: "index_cr_credits_on_artist_credit_id", using: :btree
  add_index "cr_credits", ["compilation_release_id"], name: "index_cr_credits_on_compilation_release_id", using: :btree
  add_index "cr_credits", ["job_id"], name: "index_cr_credits_on_job_id", using: :btree

  create_table "cr_format_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cr_formats", force: :cascade do |t|
    t.integer  "compilation_release_id", null: false
    t.integer  "cr_format_kind_id",      null: false
    t.integer  "quantity",               null: false
    t.integer  "no",                     null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "note"
  end

  add_index "cr_formats", ["compilation_release_id", "no"], name: "index_cr_formats_on_compilation_release_id_and_no", unique: true, using: :btree

  create_table "crf_attribute_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crf_attributes", force: :cascade do |t|
    t.integer  "cr_format_id",          null: false
    t.integer  "crf_attribute_kind_id", null: false
    t.integer  "no",                    null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "crf_attributes", ["cr_format_id", "no"], name: "index_crf_attributes_on_cr_format_id_and_no", unique: true, using: :btree

  create_table "formats", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.string   "type",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "formats", ["type"], name: "index_format_kinds_on_lower_name_and_type", unique: true, using: :btree

  create_table "identifier_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "no",               null: false
    t.string   "joinparse"
    t.integer  "artist_id",        null: false
    t.integer  "artist_credit_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "participants", ["no", "artist_credit_id"], name: "index_participants_on_artist_credit_id_and_no", unique: true, using: :btree

  create_table "pga_diagrams", primary_key: "diagramname", force: :cascade do |t|
    t.text "diagramtables"
    t.text "diagramlinks"
  end

  create_table "pga_forms", primary_key: "formname", force: :cascade do |t|
    t.text "formsource"
  end

  create_table "pga_graphs", primary_key: "graphname", force: :cascade do |t|
    t.text "graphsource"
    t.text "graphcode"
  end

  create_table "pga_images", primary_key: "imagename", force: :cascade do |t|
    t.text "imagesource"
  end

  create_table "pga_layout", primary_key: "tablename", force: :cascade do |t|
    t.integer "nrcols",   limit: 2
    t.text    "colnames"
    t.text    "colwidth"
  end

  create_table "pga_queries", primary_key: "queryname", force: :cascade do |t|
    t.string "querytype",     limit: 1
    t.text   "querycommand"
    t.text   "querytables"
    t.text   "querylinks"
    t.text   "queryresults"
    t.text   "querycomments"
  end

  create_table "pga_reports", primary_key: "reportname", force: :cascade do |t|
    t.text "reportsource"
    t.text "reportbody"
    t.text "reportprocs"
    t.text "reportoptions"
  end

  create_table "pga_scripts", primary_key: "scriptname", force: :cascade do |t|
    t.text "scriptsource"
  end

  create_table "ph_credits", force: :cascade do |t|
    t.integer  "artist_credit_id", null: false
    t.integer  "piece_head_id",    null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "ph_credits", ["artist_credit_id"], name: "index_ph_credits_on_artist_credit_id", using: :btree
  add_index "ph_credits", ["job_id"], name: "index_ph_credits_on_job_id", using: :btree
  add_index "ph_credits", ["piece_head_id"], name: "index_ph_credits_on_piece_head_id", using: :btree

  create_table "piece_heads", force: :cascade do |t|
    t.integer  "artist_credit_id"
    t.integer  "season_id"
    t.string   "title",            null: false
    t.string   "disambiguation"
    t.integer  "no"
    t.string   "type",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "piece_heads", ["type"], name: "index_piece_heads_on_lower_title", unique: true, where: "(disambiguation IS NULL)", using: :btree
  add_index "piece_heads", ["type"], name: "index_piece_heads_on_lower_title_disambiguation", unique: true, using: :btree

  create_table "piece_releases", force: :cascade do |t|
    t.integer  "piece_head_id", null: false
    t.integer  "station_id"
    t.string   "version"
    t.string   "type",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "date"
    t.integer  "date_mask"
  end

  add_index "piece_releases", ["piece_head_id"], name: "index_piece_on_piece_head_id_and_lower_version", unique: true, using: :btree
  add_index "piece_releases", ["piece_head_id"], name: "index_piece_on_unique_piece_head_id", unique: true, where: "(version IS NULL)", using: :btree

  create_table "pr_credits", force: :cascade do |t|
    t.integer  "artist_credit_id", null: false
    t.integer  "piece_release_id", null: false
    t.integer  "job_id"
    t.string   "role"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "pr_credits", ["artist_credit_id"], name: "index_pr_credits_on_artist_credit_id", using: :btree
  add_index "pr_credits", ["job_id"], name: "index_pr_credits_on_job_id", using: :btree
  add_index "pr_credits", ["piece_release_id"], name: "index_pr_credits_on_piece_release_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "serial_id",  null: false
    t.integer  "no",         null: false
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seasons", ["no", "serial_id"], name: "index_seasons_on_no_and_serial_id", unique: true, using: :btree

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
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "disambiguation"
    t.string   "type",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "tr_format_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "trf_attribute_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trf_attributes", force: :cascade do |t|
    t.integer  "track_id",              null: false
    t.integer  "trf_attribute_kind_id", null: false
    t.integer  "no",                    null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "trf_attributes", ["track_id", "no"], name: "index_trf_attributes_on_track_id_and_no", unique: true, using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "ch_credits", "artist_credits"
  add_foreign_key "ch_credits", "compilation_heads"
  add_foreign_key "ch_credits", "jobs"
  add_foreign_key "countries_compilation_heads", "compilation_heads"
  add_foreign_key "countries_compilation_heads", "countries"
  add_foreign_key "countries_piece_heads", "countries"
  add_foreign_key "countries_piece_heads", "piece_heads"
  add_foreign_key "countries_piece_releases", "countries"
  add_foreign_key "countries_piece_releases", "piece_releases"
  add_foreign_key "cr_companies", "companies"
  add_foreign_key "cr_companies", "company_roles"
  add_foreign_key "cr_credits", "artist_credits"
  add_foreign_key "cr_credits", "compilation_releases"
  add_foreign_key "cr_credits", "jobs"
  add_foreign_key "participants", "artist_credits", name: "participants_fk_artist_credits"
  add_foreign_key "participants", "artists", name: "participants_fk_artists"
  add_foreign_key "ph_credits", "artist_credits"
  add_foreign_key "ph_credits", "jobs"
  add_foreign_key "ph_credits", "piece_heads"
  add_foreign_key "piece_heads", "artist_credits", name: "piece_heads_fk_artist_credits"
  add_foreign_key "piece_heads", "seasons", name: "piece_heads_fk_seasons"
  add_foreign_key "piece_releases", "piece_heads", name: "pieces_fk_piece_heads"
  add_foreign_key "piece_releases", "stations", name: "pieces_fk_stations"
  add_foreign_key "pr_credits", "artist_credits"
  add_foreign_key "pr_credits", "jobs"
  add_foreign_key "pr_credits", "piece_releases"
  add_foreign_key "seasons", "serials", name: "seasons_fk_seasons"
end
