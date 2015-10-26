class RenameDataIdentifiersToReferences < ActiveRecord::Migration
  def change
    rename_table :source_identifiers, :references
  end
end
