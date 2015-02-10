class ArtistUniqueLowerNameDisambiguationIdx < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX artists_lower_name_disambiguation_idx
            ON artists (LOWER(name), LOWER(disambiguation))
        DDL
      end
      idx.down do
        remove_index(:artists, name: :artists_lower_name_disambiguation_idx)
      end
    end
  end
end
