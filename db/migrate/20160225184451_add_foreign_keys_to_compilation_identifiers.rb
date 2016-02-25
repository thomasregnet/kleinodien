class AddForeignKeysToCompilationIdentifiers < ActiveRecord::Migration
  def change
    add_foreign_key :compilation_identifiers, :compilation_releases
    add_foreign_key :compilation_identifiers, :identifier_types
  end
end
