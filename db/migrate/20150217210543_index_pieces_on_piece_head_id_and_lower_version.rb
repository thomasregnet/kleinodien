class IndexPiecesOnPieceHeadIdAndLowerVersion < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_on_piece_head_id_and_lower_version
            ON pieces (piece_head_id, LOWER(version))
        DDL
      end
      idx.down do
        remove_index(:pieces,
                     name: :index_piece_on_piece_head_id_and_lower_version)
      end
    end
  end
end
