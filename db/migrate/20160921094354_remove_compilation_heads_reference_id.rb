class RemoveCompilationHeadsReferenceId < ActiveRecord::Migration[5.0]
  def change
    remove_column :compilation_heads, :reference_id
    add_column :compilation_heads, :source_name, :string
    add_column :compilation_heads, :source_ident, :string
    add_foreign_key :compilation_heads,
                    :sources,
                    column: :source_name,
                    primary_key: :name
    execute <<-DDL
      CREATE UNIQUE INDEX index_compilation_heads_on_lower_title
        ON compilation_heads (type, LOWER(title))
          WHERE disambiguation IS NULL AND source_ident IS NULL;

      CREATE UNIQUE INDEX
        index_compilation_heads_on_lower_title_disambiguation
          ON compilation_heads (type, LOWER(title), LOWER(disambiguation))
            WHERE source_ident IS NULL;
    DDL
  end
end

### psql output before this migration
# kleinodien_development=> \d compilation_heads
#                                         Table "public.compilation_heads"
#       Column      |            Type             |                           Modifiers
# ------------------+-----------------------------+----------------------------------------------------------------
#  id               | integer                     | not null default nextval('compilation_heads_id_seq'::regclass)
#  artist_credit_id | integer                     |
#  title            | character varying           | not null
#  disambiguation   | character varying           |
#  type             | character varying           |
#  created_at       | timestamp without time zone | not null
#  updated_at       | timestamp without time zone | not null
#  reference_id     | integer                     |
# Indexes:
#     "compilation_heads_pkey" PRIMARY KEY, btree (id)
#     "compilation_heads_reference_id" UNIQUE, btree (reference_id) WHERE reference_id IS NOT NULL
#     "index_compilation_heads_on_lower_title" UNIQUE, btree (type, lower(title::text)) WHERE disambiguation IS NULL AND reference_id IS NULL
#     "index_compilation_heads_on_lower_title_disambiguation" UNIQUE, btree (type, lower(title::text), lower(disambiguation::text)) WHERE reference_id IS NULL
#     "index_compilation_heads_on_artist_credit_id" btree (artist_credit_id)
#     "index_compilation_heads_on_reference_id" btree (reference_id)
# Foreign-key constraints:
#     "fk_rails_09feef8331" FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id)
#     "fk_rails_afc18d626b" FOREIGN KEY (reference_id) REFERENCES "references"(id)
# Referenced by:
#     TABLE "compilation_heads_countries" CONSTRAINT "fk_rails_01ebf7126a" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
#     TABLE "compilation_releases" CONSTRAINT "fk_rails_3257861963" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
#     TABLE "ch_labels" CONSTRAINT "fk_rails_49b539283c" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
#     TABLE "compilation_heads_references" CONSTRAINT "fk_rails_5fd3bacc8c" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
#     TABLE "ch_credits" CONSTRAINT "fk_rails_60c42b31e6" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
#     TABLE "ch_companies" CONSTRAINT "fk_rails_fddf8f8bbb" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
