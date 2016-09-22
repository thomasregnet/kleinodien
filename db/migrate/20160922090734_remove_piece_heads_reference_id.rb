# coding: utf-8
class RemovePieceHeadsReferenceId < ActiveRecord::Migration[5.0]
  def change
    remove_column :piece_heads, :reference_id
    add_column :piece_heads, :source_name, :string
    add_column :piece_heads, :source_ident, :string
    add_foreign_key :piece_heads,
                    :sources,
                    column: :source_name,
                    primary_key: :name

    execute <<-DDL.gsub /^\s+/, ''
      CREATE UNIQUE INDEX index_piece_heads_source_name
        ON piece_heads (source_name)
          WHERE source_ident IS NOT NULL;
    DDL
  end
end

### psql before migration
# kleinodien_development=> \d piece_heads
#                                          Tabelle »public.piece_heads«
#       Spalte      |             Typ             |                          Attribute
# ------------------+-----------------------------+--------------------------------------------------------------
#  id               | integer                     | not null Vorgabewert nextval('piece_heads_id_seq'::regclass)
#  artist_credit_id | integer                     |
#  season_id        | integer                     |
#  title            | character varying           | not null
#  disambiguation   | character varying           |
#  no               | integer                     |
#  type             | character varying           | not null
#  created_at       | timestamp without time zone | not null
#  updated_at       | timestamp without time zone | not null
#  reference_id     | integer                     |
# Indexe:
#     "piece_heads_pkey" PRIMARY KEY, btree (id)
#     "index_piece_heads_on_lower_title" UNIQUE, btree (artist_credit_id, type, lower(title::text)) WHERE disambiguation IS NULL AND reference_id IS NULL
#     "index_piece_heads_on_lower_title_disambiguation" UNIQUE, btree (artist_credit_id, type, lower(title::text), lower(disambiguation::text))
#     "index_piece_heads_reference_id" UNIQUE, btree (reference_id) WHERE reference_id IS NOT NULL
#     "index_piece_heads_on_artist_credit_id" btree (artist_credit_id)
#     "index_piece_heads_on_reference_id" btree (reference_id)
#     "index_piece_heads_on_season_id" btree (season_id)
# Fremdschlüssel-Constraints:
#     "fk_rails_ba237bed5e" FOREIGN KEY (reference_id) REFERENCES "references"(id)
#     "piece_heads_fk_artist_credits" FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id)
#     "piece_heads_fk_seasons" FOREIGN KEY (season_id) REFERENCES seasons(id)
# Fremdschlüsselverweise von:
#     TABLE "ph_labels" CONSTRAINT "fk_rails_5b62c0dff0" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
#     TABLE "ph_credits" CONSTRAINT "fk_rails_b25e5ea472" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
#     TABLE "ph_companies" CONSTRAINT "fk_rails_b93a075402" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
#     TABLE "countries_piece_heads" CONSTRAINT "fk_rails_cf815a1510" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
#     TABLE "piece_heads_references" CONSTRAINT "fk_rails_d631e95bc9" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
#     TABLE "piece_releases" CONSTRAINT "pieces_fk_piece_heads" FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id)
