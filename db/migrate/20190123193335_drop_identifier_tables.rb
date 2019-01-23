class DropIdentifierTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :artist_identifiers
    drop_table :compilation_head_identifiers
    drop_table :compilation_release_identifiers
    drop_table :piece_head_identifiers
    drop_table :piece_release_identifiers
  end
end
