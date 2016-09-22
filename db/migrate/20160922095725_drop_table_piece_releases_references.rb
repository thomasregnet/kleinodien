# coding: utf-8
class DropTablePieceReleasesReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :piece_releases, :reference_id
    add_column :piece_releases, :source_name, :string
    add_column :piece_releases, :source_ident, :string
    add_foreign_key :piece_releases,
                    :sources,
                    column: :source_name,
                    primary_key: :name

    drop_table :piece_releases_references
  end
end

### psql before migration
# kleinodien_development=> \d piece_releases
#                                         Tabelle »public.piece_releases«
#     Spalte     |             Typ             |                            Attribute
# ---------------+-----------------------------+-----------------------------------------------------------------
#  id            | integer                     | not null Vorgabewert nextval('piece_releases_id_seq'::regclass)
#  piece_head_id | integer                     | not null
#  station_id    | integer                     |
#  version       | character varying           |
#  type          | character varying           | not null
#  created_at    | timestamp without time zone | not null
#  updated_at    | timestamp without time zone | not null
#  date          | date                        |
#  date_mask     | integer                     |
#  reference_id  | integer                     |
# Indexe:
#     "piece_releases_pkey" PRIMARY KEY, btree (id)
#     "index_piece_releases_on_piece_head_id_and_lower_version" UNIQUE, btree (piece_head_id, lower(version::text))
#     "index_piece_releases_on_unique_piece_head_id" UNIQUE, btree (piece_head_id) WHERE version IS NULL AND reference_id IS NULL
#     "index_piece_releases_reference_id" UNIQUE, btree (reference_id) WHERE reference_id IS NOT NULL
#     "index_piece_releases_on_reference_id" btree (reference_id)
#     "index_piece_releases_on_station_id" btree (station_id)
# Fremdschlüssel-Constraints:
#     "fk_rails_be469ec6db" FOREIGN KEY (reference_id) REFERENCES "references"(id)
#     "pieces_fk_piece_heads" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
#     "pieces_fk_stations" FOREIGN KEY (station_id) REFERENCES stations(id)
# Fremdschlüsselverweise von:
#     TABLE "pr_credits" CONSTRAINT "fk_rails_2ac63d8fba" FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id)
#     TABLE "pr_companies" CONSTRAINT "fk_rails_33247dd051" FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id)
#     TABLE "piece_releases_references" CONSTRAINT "fk_rails_6c261e2bcc" FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id)
#     TABLE "countries_piece_releases" CONSTRAINT "fk_rails_8b910926c7" FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id)
#     TABLE "pr_labels" CONSTRAINT "fk_rails_8e7336dad9" FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id)
#     TABLE "tracks" CONSTRAINT "fk_rails_d4da78d1c9" FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id)
