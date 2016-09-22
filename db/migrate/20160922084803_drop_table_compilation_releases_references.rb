class DropTableCompilationReleasesReferences < ActiveRecord::Migration[5.0]
  def change
    drop_table :compilation_releases_references
  end
end
