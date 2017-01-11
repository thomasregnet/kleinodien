# coding: utf-8

# kleinodien_development=> \d formats
#  Tabelle »public.formats«
#  Spalte | Typ  | Attribute
# --------+------+-----------
#  abbr   | text | not null
#  name   | text | not null
# Indexe:
#     "formats_pkey" PRIMARY KEY, btree (abbr)
#     "formats_lower_idx" UNIQUE, btree (lower(name))
# Fremdschlüsselverweise von:
#     TABLE "cr_formats" CONSTRAINT "cr_formats_abbr_fkey" FOREIGN KEY (abbr) REFERENCES formats(abbr)
#     TABLE "compilation_tracks" CONSTRAINT "fk_compilation_tracks_format_abbr" FOREIGN KEY (format_abbr) REFERENCES formats(abbr)
#     TABLE "repositories" CONSTRAINT "fk_repositories_format_abbr" FOREIGN KEY (format_abbr) REFERENCES formats(abbr)

# kleinodien_development=> \d format_details
# Tabelle »public.format_details«
#  Spalte | Typ  | Attribute
# --------+------+-----------
#  abbr   | text | not null
#  name   | text | not null
# Indexe:
#     "format_details_pkey" PRIMARY KEY, btree (abbr)
#     "format_details_lower_idx" UNIQUE, btree (lower(name))
# Fremdschlüsselverweise von:
#     TABLE "cr_format_details" CONSTRAINT "cr_format_details_abbr_fkey" FOREIGN KEY (abbr) REFERENCES format_details(abbr)
#     TABLE "ct_format_details" CONSTRAINT "ct_format_details_abbr_fkey" FOREIGN KEY (abbr) REFERENCES format_details(abbr)
#     TABLE "repository_format_details" CONSTRAINT "repository_format_details_abbr_fkey" FOREIGN KEY (abbr) REFERENCES format_details(abbr)
class SurrogateKeysForFormatsAndFormatDetails < ActiveRecord::Migration[5.0]
  def change
    ['formats', 'format_details'].each do |table|
      execute <<-DDL
        ALTER TABLE #{table} DROP COLUMN abbr CASCADE;
        ALTER TABLE #{table} ADD COLUMN abbr TEXT UNIQUE;
        ALTER TABLE #{table} ADD COLUMN id SERIAL PRIMARY KEY;
      DDL
    end

    # to be able to rename all format_abbr columns in a loop
    rename_column :cr_formats, :abbr, :format_abbr

    ['compilation_tracks', 'cr_formats', 'repositories'].each do |table|
      execute <<-DDL
        ALTER TABLE #{table} DROP COLUMN format_abbr;
        ALTER TABLE #{table} ADD COLUMN format_id INTEGER;
        ALTER TABLE #{table} ADD CONSTRAINT fk_#{table}_format_id
          FOREIGN KEY (format_id) REFERENCES formats (id);
      DDL
    end


    referencing_details = [
      'cr_format_details',
      'ct_format_details',
      'repository_format_details'
    ]
    referencing_details.each do |table|
      execute <<-DDL
        ALTER TABLE #{table} DROP COLUMN abbr;
        ALTER TABLE #{table} ADD COLUMN format_detail_id INTEGER;
        ALTER TABLE #{table} ADD CONSTRAINT fk_#{table}_format_detail_id
          FOREIGN KEY (format_detail_id) REFERENCES format_details (id);
      DDL
    end
  end
end
