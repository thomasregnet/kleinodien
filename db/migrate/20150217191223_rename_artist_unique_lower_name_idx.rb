class RenameArtistUniqueLowerNameIdx < ActiveRecord::Migration[4.2]
  def change
    old = 'artist_lower_name_idx'
    new = 'index_artists_on_lower_name'
    reversible do |rename|
      rename.up do
        execute "ALTER INDEX #{old} RENAME TO #{new}"
      end
      rename.down do
        execute "ALTER INDEX #{new} RENAME TO #{old}"
      end
    end
  end
end
