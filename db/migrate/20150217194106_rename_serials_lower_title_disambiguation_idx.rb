class RenameSerialsLowerTitleDisambiguationIdx < ActiveRecord::Migration
  def change
    old = 'serials_lower_title_disambiguation_idx'
    new = 'index_serials_on_lower_disambiguation_and_title'
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
