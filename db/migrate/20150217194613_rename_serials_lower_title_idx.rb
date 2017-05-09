class RenameSerialsLowerTitleIdx < ActiveRecord::Migration[4.2]
  def change
    old = 'serials_lower_title_idx'
    new = 'index_serials_on_lower_title'
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
