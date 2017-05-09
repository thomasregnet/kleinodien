class CompilationHeadsIndicesRelevanReference < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        remove_index(
          :compilation_heads,
          name: :index_compilation_heads_on_lower_title
        )
        remove_index(
          :compilation_heads,
          name: :index_compilation_heads_on_lower_title_disambiguation
        )

        execute <<-DDL
          CREATE UNIQUE INDEX index_compilation_heads_on_lower_title
            ON compilation_heads (type, LOWER(title))
              WHERE disambiguation IS NULL AND reference_id IS NULL;

          CREATE UNIQUE INDEX
            index_compilation_heads_on_lower_title_disambiguation
              ON compilation_heads (type, LOWER(title), LOWER(disambiguation))
                WHERE reference_id IS NULL;
        DDL
      end
      idx.down do
        remove_index(
          :compilation_heads,
          name: :index_compilation_heads_on_lower_title
        )
        remove_index(
          :compilation_heads,
          name: :index_compilation_heads_on_lower_title_disambiguation
        )

        execute <<-DDL
          CREATE UNIQUE INDEX index_compilation_heads_on_lower_title
            ON compilation_heads (type, LOWER(title))
              WHERE disambiguation IS NULL;

          CREATE UNIQUE INDEX
            index_compilation_heads_on_lower_title_disambiguation
              ON compilation_heads (type, LOWER(title), LOWER(disambiguation))
        DDL
      end
    end
  end
end
