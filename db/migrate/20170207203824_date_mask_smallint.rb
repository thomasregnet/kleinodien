class DateMaskSmallint < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE compilation_releases DROP COLUMN date_mask;
      ALTER TABLE compilation_releases ADD COLUMN date_mask smallint;

      ALTER TABLE piece_releases DROP COLUMN date_mask;
      ALTER TABLE piece_releases ADD COLUMN date_mask smallint;
    DDL
  end
end
