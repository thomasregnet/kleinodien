class AddDataImportToCompilationReleases < ActiveRecord::Migration[5.1]
  def change
    add_reference :compilation_releases, :data_import, foreign_key: true
  end
end
