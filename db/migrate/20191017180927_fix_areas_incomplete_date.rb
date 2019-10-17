class FixAreasIncompleteDate < ActiveRecord::Migration[6.0]
  def change
    remove_column :areas, :begin_date_year
    remove_column :areas, :begin_date_month
    remove_column :areas, :begin_date_day

    remove_column :areas, :end_date_year
    remove_column :areas, :end_date_month
    remove_column :areas, :end_date_day

    add_column :areas, :begin_date, :date
    add_column :areas, :begin_date_mask, :smallint

    add_column :areas, :end_date, :date
    add_column :areas, :end_date_mask, :smallint
  end
end
