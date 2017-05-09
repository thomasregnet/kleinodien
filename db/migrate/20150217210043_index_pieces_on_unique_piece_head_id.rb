class IndexPiecesOnUniquePieceHeadId < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_on_unique_piece_head_id
            ON pieces (piece_head_id)
              WHERE version IS NULL;
        DDL
      end
      idx.down do
        remove_index(:pieces, name: :index_piece_on_unique_piece_head_id)
      end
    end
  end
end
