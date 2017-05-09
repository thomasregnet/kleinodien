class AddIndexCompilationHeadOnReferenceId < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX compilation_heads_reference_id
            ON compilation_heads (reference_id)
              WHERE reference_id IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index(
          :compilation_heads,
          name: :compilation_heads_reference_id
        )
      end
    end
  end
end
