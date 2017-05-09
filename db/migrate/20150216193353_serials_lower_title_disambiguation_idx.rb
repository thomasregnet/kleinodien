class SerialsLowerTitleDisambiguationIdx < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX serials_lower_title_disambiguation_idx
            ON serials (LOWER(title), LOWER(disambiguation))
        DDL
      end
      idx.down do
        remove_index :serials, name: :serials_lower_title_disambiguation_idx
      end
    end
  end
end
