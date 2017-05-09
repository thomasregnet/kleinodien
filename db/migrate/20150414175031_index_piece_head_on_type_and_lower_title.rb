class IndexPieceHeadOnTypeAndLowerTitle < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_heads_on_lower_title
            ON piece_heads (type, LOWER(title))
              WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index(:piece_heads, name: :index_piece_heads_on_lower_title)
      end
    end
  end
end
