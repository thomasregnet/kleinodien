class IndexPieceHeadsSourceNameSourceIdentType < ActiveRecord::Migration[5.0]
  def change
    remove_index :piece_heads, name: :index_piece_heads_source_name

    execute <<-DDL.gsub /^\s+/, ''
      CREATE UNIQUE INDEX index_piece_heads_source_name_source_ident_type
        ON piece_heads (source_name, source_ident, type)
          WHERE source_ident IS NOT NULL;
    DDL
  end
end
