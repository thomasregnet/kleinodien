class NewIndecesForArtists < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE UNIQUE INDEX index_artists_on_lower_name
        ON artists (LOWER(name))
          WHERE "disambiguation" IS NULL AND "source_ident" IS NULL;

      CREATE UNIQUE INDEX index_artists_on_lower_disambiguation_and_name
        ON artists (LOWER(name), LOWER(disambiguation))
          WHERE "source_ident" IS NULL;
    DDL
  end
end
