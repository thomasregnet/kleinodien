class AddSourceIdentifierIdToCompilationReleases < ActiveRecord::Migration
  def change
    add_reference :compilation_releases, :source_identifier, index: true, foreign_key: true
  end
end
