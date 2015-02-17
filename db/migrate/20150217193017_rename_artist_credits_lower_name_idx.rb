class RenameArtistCreditsLowerNameIdx < ActiveRecord::Migration
  def change
    old = 'artist_credits_lower_name_idx'
    new = 'index_artist_credits_on_lower_name'
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
