# coding: utf-8
class RemoveCompilationReleasesReferenceId < ActiveRecord::Migration[5.0]
  def change
    remove_column :compilation_releases, :reference_id
    add_column :compilation_releases, :source_name, :string
    add_column :compilation_releases, :source_ident, :string
    add_foreign_key :compilation_releases,
                    :sources,
                    column: :source_name,
                    primary_key: :name

    execute <<-DDL
      CREATE UNIQUE INDEX
        index_compilation_releases_on_lower_version
          ON compilation_releases (type, compilation_head_id, LOWER(version))
            WHERE source_ident IS NULL;
    DDL
  end
end

### psql output before this migration
# kleinodien_development=> \d compilation_releases
#                                            Tabelle »public.compilation_releases«
#        Spalte        |             Typ             |                               Attribute
# ---------------------+-----------------------------+-----------------------------------------------------------------------
#  id                  | integer                     | not null Vorgabewert nextval('compilation_releases_id_seq'::regclass)
#  compilation_head_id | integer                     | not null
#  version             | character varying           |
#  type                | character varying           | not null
#  created_at          | timestamp without time zone | not null
#  updated_at          | timestamp without time zone | not null
#  date                | date                        |
#  date_mask           | integer                     |
#  reference_id        | integer                     |
# Indexe:
#     "compilation_releases_pkey" PRIMARY KEY, btree (id)
#     "compilation_releases_reference_id" UNIQUE, btree (reference_id) WHERE reference_id IS NOT NULL
#     "index_compilation_releases_on_compilation_head_id" UNIQUE, btree (compilation_head_id)
#     "index_compilation_releases_on_compilation_head_id_lower_version" UNIQUE, btree (compilation_head_id, lower(version::text))
#     "index_compilation_releases_on_reference_id" btree (reference_id)
# Fremdschlüssel-Constraints:
#     "fk_rails_3257861963" FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id)
#     "fk_rails_aec95c765c" FOREIGN KEY (reference_id) REFERENCES "references"(id)
# Fremdschlüsselverweise von:
#     TABLE "tracks" CONSTRAINT "fk_rails_04307d4c11" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "compilation_releases_references" CONSTRAINT "fk_rails_5f9a1ada18" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "cr_companies" CONSTRAINT "fk_rails_ab22361422" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "compilation_releases_countries" CONSTRAINT "fk_rails_c0c37ae7ab" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "cr_labels" CONSTRAINT "fk_rails_d560853ced" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "cr_formats" CONSTRAINT "fk_rails_d6ac88b699" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "compilation_identifiers" CONSTRAINT "fk_rails_d9764bf4b0" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
#     TABLE "cr_credits" CONSTRAINT "fk_rails_e562cf7d82" FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id)
