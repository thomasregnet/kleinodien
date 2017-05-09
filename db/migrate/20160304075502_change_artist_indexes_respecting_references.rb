class ChangeArtistIndexesRespectingReferences < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        remove_indexes
        # remove_index :artists, name: :index_artists_on_lower_name
        # remove_index :artists,
        #              name: :index_artists_on_lower_disambiguation_and_name

        execute <<-DDL
          CREATE UNIQUE INDEX index_artists_on_lower_name
            ON artists (LOWER(name))
              WHERE "disambiguation" IS NULL AND "reference_id" IS NULL;

           CREATE UNIQUE INDEX index_artists_on_lower_disambiguation_and_name
            ON artists (LOWER(name), LOWER(disambiguation))
              WHERE "reference_id" IS NULL;
        DDL
      end
      idx.down do
        remove_indexes

        execute <<-DDL
          CREATE UNIQUE INDEX index_artists_on_lower_name
            ON artists (LOWER(name))
              WHERE disambiguation IS NULL;

           CREATE UNIQUE INDEX index_artists_on_lower_disambiguation_and_name
            ON artists (LOWER(name), LOWER(disambiguation));
        DDL
      end
    end
  end

  def remove_indexes
    remove_index :artists, name: :index_artists_on_lower_name
    remove_index :artists,
                 name: :index_artists_on_lower_disambiguation_and_name
  end
end
