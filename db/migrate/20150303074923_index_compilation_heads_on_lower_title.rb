class IndexCompilationHeadsOnLowerTitle < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_compilation_heads_on_lower_title
            ON compilation_heads (LOWER(title))
              WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index(:compilation_heads,
                     name: :index_compilation_heads_on_lower_title)
      end
    end
  end
end
