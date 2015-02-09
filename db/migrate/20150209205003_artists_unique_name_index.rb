class ArtistsUniqueNameIndex < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX artists_unique_lower_name_idx
            ON artists
              (LOWER(name))
                WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index(:artists, name: :artists_unique_lower_name_idx)
      end
    end
  end
end
