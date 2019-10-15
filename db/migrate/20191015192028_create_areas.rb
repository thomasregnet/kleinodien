class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name, null: false
      t.string :sort_name, null: false
      t.integer :begin_date_year
      t.integer :begin_date_month
      t.integer :begin_date_day
      t.integer :end_date_year
      t.integer :end_date_month
      t.integer :end_date_day
      t.string :type

      t.timestamps
    end

    execute <<~DDL
      CREATE UNIQUE INDEX index_areas_on_lower_name
      ON areas (LOWER(name));

      CREATE UNIQUE INDEX index_areas_on_lower_sort_name
      ON areas (LOWER(sort_name));
    DDL
  end
end
