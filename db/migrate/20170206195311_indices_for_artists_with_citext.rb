class IndicesForArtistsWithCitext < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE UNIQUE INDEX ON artists(name)
      WHERE "disambiguation"       IS NULL
      AND   "artist_identifier_id" IS NULL;

      CREATE UNIQUE INDEX ON artists(name, disambiguation)
      WHERE "artist_identifier_id" IS NULL;
    DDL
  end
end
