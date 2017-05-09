class SerialsLowerTitleIdx < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX serials_lower_title_idx
            ON serials (LOWER(title))
              WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index :serials, name: :serials_lower_title_idx
      end
    end
  end
end
