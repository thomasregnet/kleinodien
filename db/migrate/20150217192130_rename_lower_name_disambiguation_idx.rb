class RenameLowerNameDisambiguationIdx < ActiveRecord::Migration[4.2]
  def change
    old = 'artists_lower_name_disambiguation_idx'
    new = 'index_artists_on_lower_disambiguation_and_name'
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
