class AddSourceIdentifierIdToCompilationReleases < ActiveRecord::Migration[4.2]
  def change
    add_reference :compilation_releases, :source_identifier, index: true, foreign_key: true
  end
end
