class RenameIdentifiers < ActiveRecord::Migration[5.1]
  def change
    reversible do |rename|
      rename.up do
        rename_table :ch_identifiers, :compilation_head_identifiers
        rename_table :cr_identifiers, :compilation_release_identifiers
      end
      rename.down do
        rename_table :compilation_head_identifiers,    :ch_identifiers
        rename_table :compilation_release_identifiers, :cr_identifiers
      end
    end
  end
end
