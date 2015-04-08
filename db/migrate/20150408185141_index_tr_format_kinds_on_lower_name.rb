class IndexTrFormatKindsOnLowerName < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_tr_format_kinds_on_lower_name
            ON tr_format_kinds (LOWER(name));
        DDL
      end
      idx.down do
        remove_index(
          :tr_format_kinds,
          name: :index_tr_format_kinds_on_lower_name
        )
      end
    end
  end
end
