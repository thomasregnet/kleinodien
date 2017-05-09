class IndexCompilationHeadsOnLowerTitleDisambiguation < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX
            index_compilation_heads_on_lower_title_disambiguation
              ON compilation_heads (LOWER(title), LOWER(disambiguation))
        DDL
      end
      idx.down do
        remove_index(
          :compilation_heads,
          name: :index_compilation_heads_on_lower_title_disambiguation)
      end
    end
  end
end
