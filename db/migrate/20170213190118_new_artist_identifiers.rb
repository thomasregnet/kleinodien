class NewArtistIdentifiers < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE artists DROP COLUMN artist_identifier_id;
      DROP TABLE artist_identifiers_artists;
      DROP TABLE artist_identifiers;

      CREATE TABLE artist_identifiers (
        id           bigserial PRIMARY KEY,
        value        text                        NOT NULL,
        artist_id    integer                     NOT NULL,
        source_id    integer                     NOT NULL,
        created_at   timestamp without time zone NOT NULL,
        updated_at   timestamp without time zone NOT NULL,
        FOREIGN KEY (artist_id) REFERENCES artists (id),
        FOREIGN KEY (source_id) REFERENCES sources (id)
      );
    DDL
  end
end
