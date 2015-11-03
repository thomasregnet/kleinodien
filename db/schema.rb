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

ActiveRecord::Schema.define(version: 20151103200251) do

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

  create_table "ch_companies", force: :cascade do |t|
    t.integer  "compilation_head_id", null: false
    t.integer  "company_id",          null: false
    t.integer  "company_role_id",     null: false
    t.string   "catalog_no"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "ch_companies", ["company_id"], name: "index_ch_companies_on_company_id", using: :btree
  add_index "ch_companies", ["company_role_id"], name: "index_ch_companies_on_company_role_id", using: :btree
  add_index "ch_companies", ["compilation_head_id"], name: "index_ch_companies_on_compilation_head_id", using: :btree

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

  create_table "ch_labels", force: :cascade do |t|
    t.integer  "compilation_head_id", null: false
    t.integer  "company_id",          null: false
    t.string   "catalog_no"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "ch_labels", ["company_id"], name: "index_ch_labels_on_company_id", using: :btree
  add_index "ch_labels", ["compilation_head_id"], name: "index_ch_labels_on_compilation_head_id", using: :btree

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
    t.integer  "reference_id"
  end

  add_index "compilation_heads", ["reference_id"], name: "compilation_heads_reference_id", unique: true, where: "(reference_id IS NOT NULL)", using: :btree
  add_index "compilation_heads", ["reference_id"], name: "index_compilation_heads_on_reference_id", using: :btree
  add_index "compilation_heads", ["type"], name: "index_compilation_heads_on_lower_title", unique: true, where: "(disambiguation IS NULL)", using: :btree
  add_index "compilation_heads", ["type"], name: "index_compilation_heads_on_lower_title_disambiguation", unique: true, using: :btree

  create_table "compilation_heads_countries", id: false, force: :cascade do |t|
    t.integer "country_id",          null: false
    t.integer "compilation_head_id", null: false
  end

  add_index "compilation_heads_countries", ["compilation_head_id"], name: "index_compilation_heads_countries_on_compilation_head_id", using: :btree
  add_index "compilation_heads_countries", ["country_id", "compilation_head_id"], name: "index_phc_on_country_id_and_compilation_head_id", unique: true, using: :btree
  add_index "compilation_heads_countries", ["country_id"], name: "index_compilation_heads_countries_on_country_id", using: :btree

  create_table "compilation_heads_references", id: false, force: :cascade do |t|
    t.integer "compilation_head_id", null: false
    t.integer "reference_id",        null: false
  end

  add_index "compilation_heads_references", ["compilation_head_id"], name: "index_compilation_heads_references_on_compilation_head_id", using: :btree
  add_index "compilation_heads_references", ["reference_id"], name: "index_compilation_heads_references_on_reference_id", using: :btree

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
    t.integer  "reference_id"
  end

  add_index "compilation_releases", ["compilation_head_id"], name: "index_compilation_releases_on_compilation_head_id", unique: true, using: :btree
  add_index "compilation_releases", ["compilation_head_id"], name: "index_compilation_releases_on_compilation_head_id_lower_version", unique: true, using: :btree
  add_index "compilation_releases", ["reference_id"], name: "compilation_releases_reference_id", unique: true, where: "(reference_id IS NOT NULL)", using: :btree
  add_index "compilation_releases", ["reference_id"], name: "index_compilation_releases_on_reference_id", using: :btree

  create_table "compilation_releases_countries", id: false, force: :cascade do |t|
    t.integer "compilation_release_id", null: false
    t.integer "country_id",             null: false
  end

  add_index "compilation_releases_countries", ["compilation_release_id", "country_id"], name: "index_compilation_releases_countries_no_and_ids", unique: true, using: :btree

  create_table "compilation_releases_references", id: false, force: :cascade do |t|
    t.integer "compilation_release_id"
    t.integer "reference_id"
  end

  add_index "compilation_releases_references", ["compilation_release_id"], name: "index_compilation_releases_references_on_compilation_release_id", using: :btree
  add_index "compilation_releases_references", ["reference_id"], name: "index_compilation_releases_references_on_reference_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "cr_labels", force: :cascade do |t|
    t.integer  "compilation_release_id", null: false
    t.integer  "company_id",             null: false
    t.string   "catalog_no"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cr_labels", ["company_id"], name: "index_cr_labels_on_company_id", using: :btree
  add_index "cr_labels", ["compilation_release_id"], name: "index_cr_labels_on_compilation_release_id", using: :btree

  create_table "crf_detail_kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "abbr"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crf_details", force: :cascade do |t|
    t.integer  "cr_format_id",          null: false
    t.integer  "crf_attribute_kind_id", null: false
    t.integer  "no",                    null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "crf_details", ["cr_format_id", "no"], name: "index_crf_details_on_cr_format_id_and_no", unique: true, using: :btree

  create_table "data_suppliers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "ph_companies", force: :cascade do |t|
    t.integer  "piece_head_id",   null: false
    t.integer  "company_id",      null: false
    t.integer  "company_role_id", null: false
    t.string   "catalog_no"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "ph_companies", ["company_id"], name: "index_ph_companies_on_company_id", using: :btree
  add_index "ph_companies", ["company_role_id"], name: "index_ph_companies_on_company_role_id", using: :btree
  add_index "ph_companies", ["piece_head_id"], name: "index_ph_companies_on_piece_head_id", using: :btree

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

  create_table "ph_labels", force: :cascade do |t|
    t.integer  "piece_head_id", null: false
    t.integer  "company_id",    null: false
    t.string   "catalog_no"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ph_labels", ["company_id"], name: "index_ph_labels_on_company_id", using: :btree
  add_index "ph_labels", ["piece_head_id"], name: "index_ph_labels_on_piece_head_id", using: :btree

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
  end

  add_index "piece_heads", ["reference_id"], name: "index_piece_heads_on_reference_id", using: :btree
  add_index "piece_heads", ["reference_id"], name: "index_piece_heads_reference_id", unique: true, where: "(reference_id IS NOT NULL)", using: :btree
  add_index "piece_heads", ["type"], name: "index_piece_heads_on_lower_title", unique: true, where: "(disambiguation IS NULL)", using: :btree
  add_index "piece_heads", ["type"], name: "index_piece_heads_on_lower_title_disambiguation", unique: true, using: :btree

  create_table "piece_heads_references", id: false, force: :cascade do |t|
    t.integer "piece_head_id"
    t.integer "reference_id"
  end

  add_index "piece_heads_references", ["piece_head_id"], name: "index_piece_heads_references_on_piece_head_id", using: :btree
  add_index "piece_heads_references", ["reference_id"], name: "index_piece_heads_references_on_reference_id", using: :btree

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
  end

  add_index "piece_releases", ["piece_head_id"], name: "index_piece_on_piece_head_id_and_lower_version", unique: true, using: :btree
  add_index "piece_releases", ["piece_head_id"], name: "index_piece_on_unique_piece_head_id", unique: true, where: "(version IS NULL)", using: :btree
  add_index "piece_releases", ["reference_id"], name: "index_piece_releases_on_reference_id", using: :btree
  add_index "piece_releases", ["reference_id"], name: "index_piece_releases_reference_id", unique: true, where: "(reference_id IS NOT NULL)", using: :btree

  create_table "piece_releases_references", id: false, force: :cascade do |t|
    t.integer "piece_release_id"
    t.integer "reference_id"
  end

  add_index "piece_releases_references", ["piece_release_id"], name: "index_piece_releases_references_on_piece_release_id", using: :btree
  add_index "piece_releases_references", ["reference_id"], name: "index_piece_releases_references_on_reference_id", using: :btree

  create_table "pr_companies", force: :cascade do |t|
    t.integer  "piece_release_id", null: false
    t.integer  "company_id",       null: false
    t.integer  "company_role_id",  null: false
    t.string   "catalog_no"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "pr_companies", ["company_id"], name: "index_pr_companies_on_company_id", using: :btree
  add_index "pr_companies", ["company_role_id"], name: "index_pr_companies_on_company_role_id", using: :btree
  add_index "pr_companies", ["piece_release_id"], name: "index_pr_companies_on_piece_release_id", using: :btree

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

  create_table "pr_labels", force: :cascade do |t|
    t.integer  "piece_release_id", null: false
    t.integer  "company_id",       null: false
    t.string   "catalog_no"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "pr_labels", ["company_id"], name: "index_pr_labels_on_company_id", using: :btree
  add_index "pr_labels", ["piece_release_id"], name: "index_pr_labels_on_piece_release_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.integer  "data_supplier_id", null: false
    t.string   "identifier",       null: false
    t.string   "type",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "references", ["data_supplier_id", "identifier", "type"], name: "index_src_id_on_data_src_ident_type", unique: true, using: :btree
  add_index "references", ["data_supplier_id"], name: "index_references_on_data_supplier_id", using: :btree

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

  create_table "tr_details", force: :cascade do |t|
    t.integer  "track_id",              null: false
    t.integer  "trf_attribute_kind_id", null: false
    t.integer  "no",                    null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "tr_details", ["track_id", "no"], name: "index_tr_details_on_track_id_and_no", unique: true, using: :btree

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

  add_foreign_key "ch_companies", "companies"
  add_foreign_key "ch_companies", "company_roles"
  add_foreign_key "ch_companies", "compilation_heads"
  add_foreign_key "ch_credits", "artist_credits"
  add_foreign_key "ch_credits", "compilation_heads"
  add_foreign_key "ch_credits", "jobs"
  add_foreign_key "ch_labels", "companies"
  add_foreign_key "ch_labels", "compilation_heads"
  add_foreign_key "compilation_heads", "\"references\"", column: "reference_id"
  add_foreign_key "compilation_heads_countries", "compilation_heads"
  add_foreign_key "compilation_heads_countries", "countries"
  add_foreign_key "compilation_heads_references", "\"references\"", column: "reference_id"
  add_foreign_key "compilation_heads_references", "compilation_heads"
  add_foreign_key "compilation_releases", "\"references\"", column: "reference_id"
  add_foreign_key "compilation_releases_references", "\"references\"", column: "reference_id"
  add_foreign_key "compilation_releases_references", "compilation_releases"
  add_foreign_key "countries_piece_heads", "countries"
  add_foreign_key "countries_piece_heads", "piece_heads"
  add_foreign_key "countries_piece_releases", "countries"
  add_foreign_key "countries_piece_releases", "piece_releases"
  add_foreign_key "cr_companies", "companies"
  add_foreign_key "cr_companies", "company_roles"
  add_foreign_key "cr_credits", "artist_credits"
  add_foreign_key "cr_credits", "compilation_releases"
  add_foreign_key "cr_credits", "jobs"
  add_foreign_key "cr_labels", "companies"
  add_foreign_key "cr_labels", "compilation_releases"
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
  add_foreign_key "seasons", "serials", name: "seasons_fk_seasons"
end
