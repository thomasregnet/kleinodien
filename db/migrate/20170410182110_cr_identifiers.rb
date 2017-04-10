class CrIdentifiers < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE TABLE cr_identifiers (
        id                     bigserial PRIMARY KEY,
        value                  text                        NOT NULL,
        compilation_release_id integer                     NOT NULL,
        source_id              integer                     NOT NULL,
        created_at             timestamp without time zone NOT NULL,
        updated_at             timestamp without time zone NOT NULL,

        FOREIGN KEY (compilation_release_id)
          REFERENCES compilation_releases (id),
        FOREIGN KEY (source_id) REFERENCES sources (id)
      );

      ALTER TABLE compilation_releases DROP COLUMN source_ident;
      ALTER TABLE compilation_releases DROP COLUMN source_id;
    DDL
  end
end
