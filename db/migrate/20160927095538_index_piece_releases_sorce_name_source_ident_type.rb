class IndexPieceReleasesSorceNameSourceIdentType < ActiveRecord::Migration[5.0]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX
            "index_piece_releases_sorce_name_sorce_ident_type"
              ON "piece_releases" (source_name, source_ident, type)
                WHERE "source_ident" IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index :piece_releases,
                     name: :index_piece_releases_sorce_name_sorce_ident_type
      end
    end
  end
end
