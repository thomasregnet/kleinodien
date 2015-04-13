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

ActiveRecord::Schema.define(version: 20150413172155) do

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

  create_table "compilation_heads", force: :cascade do |t|
    t.integer  "artist_credit_id"
    t.string   "title",            null: false
    t.string   "disambiguation"
    t.string   "type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

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
    t.string   "name",        null: false
    t.string   "explanation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "seasons", force: :cascade do |t|
    t.integer  "serial_id",  null: false
    t.integer  "no",         null: false
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "seasons", ["no", "serial_id"], name: "index_seasons_on_no_and_serial_id", unique: true, using: :btree

  create_table "section_formats", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "abbr",        null: false
    t.string   "explanation"
    t.integer  "rpm"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  add_foreign_key "participants", "artist_credits", name: "participants_fk_artist_credits"
  add_foreign_key "participants", "artists", name: "participants_fk_artists"
  add_foreign_key "piece_heads", "artist_credits", name: "piece_heads_fk_artist_credits"
  add_foreign_key "piece_heads", "seasons", name: "piece_heads_fk_seasons"
  add_foreign_key "piece_releases", "piece_heads", name: "pieces_fk_piece_heads"
  add_foreign_key "piece_releases", "stations", name: "pieces_fk_stations"
  add_foreign_key "seasons", "serials", name: "seasons_fk_seasons"
end
