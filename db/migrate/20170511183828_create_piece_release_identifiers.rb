class CreatePieceReleaseIdentifiers < ActiveRecord::Migration[5.1]
  def change
    execute <<-DDL
      CREATE TABLE piece_release_identifiers (
        id               bigserial PRIMARY KEY,
        value            text                        NOT NULL,
        piece_release_id integer                     NOT NULL,
        source_id        integer                     NOT NULL,
        created_at       timestamp without time zone NOT NULL,
        updated_at       timestamp without time zone NOT NULL,

        FOREIGN KEY (piece_release_id) REFERENCES piece_releases (id),
        FOREIGN KEY (source_id) REFERENCES sources (id)
      );

      ALTER TABLE piece_releases DROP COLUMN source_ident;
      ALTER TABLE piece_releases DROP COLUMN source_id;
    DDL
  end
end
