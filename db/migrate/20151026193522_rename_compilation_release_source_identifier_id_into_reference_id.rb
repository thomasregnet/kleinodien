class RenameCompilationReleaseSourceIdentifierIdIntoReferenceId < ActiveRecord::Migration
  def change
    rename_column :compilation_releases, :source_identifier_id, :reference_id
  end
end
