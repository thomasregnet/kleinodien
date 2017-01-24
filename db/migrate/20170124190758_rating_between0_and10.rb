class RatingBetween0And10 < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE ratings ADD CONSTRAINT ratings_value_between_0_and_10 CHECK (
        value >= 0 AND value <= 10
      );
    DDL
  end
end
