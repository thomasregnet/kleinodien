class ArtistUniqueLowerNameIdx < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX artist_lower_name_idx
            ON artists (LOWER(name))
              WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index(:artists, name: :artist_lower_name_idx)
      end
    end
  end
end
