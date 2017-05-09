class IndexPiecesOnUniquePieceHeadIdRespectReference < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        remove_index :piece_releases,
                     name: :index_piece_on_unique_piece_head_id

        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_on_unique_piece_head_id
            ON piece_releases (piece_head_id)
              WHERE version IS NULL AND reference_id IS NULL;
        DDL
      end
      idx.down do
        remove_index :piece_releases,
                     name: :index_piece_on_unique_piece_head_id

        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_on_unique_piece_head_id
            ON piece_releasess (piece_head_id)
              WHERE version IS NULL;
        DDL
      end
    end
  end
end
