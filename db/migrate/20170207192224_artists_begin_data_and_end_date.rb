class ArtistsBeginDataAndEndDate < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE artists ADD COLUMN begin_date date;
      ALTER TABLE artists ADD COLUMN begin_date_mask smallint;
      ALTER TABLE artists ADD COLUMN end_date date;
      ALTER TABLE artists ADD COLUMN end_date_mask smallint;
    DDL
  end
end
