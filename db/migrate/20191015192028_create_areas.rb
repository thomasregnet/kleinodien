class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :sort_name
      t.integer :begin_date_year
      t.integer :begin_date_month
      t.integer :begin_date_day
      t.integer :end_date_year
      t.integer :end_date_month
      t.integer :end_date_day
      t.string :type

      t.timestamps
    end
  end
end
