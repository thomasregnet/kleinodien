class AddIndexPieceHeadOnReferenceId < ActiveRecord::Migration
  def change
     reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX index_piece_heads_reference_id
            ON piece_heads (reference_id)
              WHERE reference_id IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index(
          :piece_heads,
          name: :index_piece_heads_reference_id
        )
      end
    end
  end
end
