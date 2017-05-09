class AddIndexPieceReleaseOnReferenceId < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX index_piece_releases_reference_id
            ON piece_releases (reference_id)
              WHERE reference_id IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index(
          :piece_releases,
          name: :index_piece_releases_reference_id
        )
      end
    end
  end
end
