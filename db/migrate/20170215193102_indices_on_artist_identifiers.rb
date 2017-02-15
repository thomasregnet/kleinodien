class IndicesOnArtistIdentifiers < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE UNIQUE INDEX ON artist_identifiers (artist_id, source_id);
      CREATE UNIQUE INDEX ON artist_identifiers (source_id, value);
    DDL
  end
end
