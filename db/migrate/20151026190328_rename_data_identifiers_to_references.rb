class RenameDataIdentifiersToReferences < ActiveRecord::Migration[4.2]
  def change
    rename_table :source_identifiers, :references
  end
end
