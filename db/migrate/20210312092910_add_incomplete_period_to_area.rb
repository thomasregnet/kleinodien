class AddIncompletePeriodToArea < ActiveRecord::Migration[6.1]
  def change
    remove_column :areas, :begin_date, :date
    remove_column :areas, :begin_date_mask, :smallint
    remove_column :areas, :end_date, :date
    remove_column :areas, :end_date_mask, :smallint

    add_column :areas, :begin_date_year, :smallint
    add_column :areas, :begin_date_month, :smallint
    add_column :areas, :begin_date_day, :smallint
    add_column :areas, :end_date_year, :smallint
    add_column :areas, :end_date_month, :smallint
    add_column :areas, :end_date_day, :smallint
  end
end
