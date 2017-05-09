class RenameCompilationReleaseSourceIdentifierIdIntoReferenceId < ActiveRecord::Migration[4.2]
  def change
    rename_column :compilation_releases, :source_identifier_id, :reference_id
  end
end
