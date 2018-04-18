class AddCodesToCompilationHeads < ActiveRecord::Migration[5.2]
  def change
    add_column :compilation_heads, :brainz_code, :uuid
    add_column :compilation_heads, :discogs_code, :bigint
    add_column :compilation_heads, :wikidata_code, :bigint
  end
end
