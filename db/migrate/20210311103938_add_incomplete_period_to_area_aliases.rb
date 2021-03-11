class AddIncompletePeriodToAreaAliases < ActiveRecord::Migration[6.1]
  def change
    remove_column :area_aliases, :begin_date, :date
    remove_column :area_aliases, :begin_date_mask, :smallint
    remove_column :area_aliases, :end_date, :date
    remove_column :area_aliases, :end_date_mask, :smallint

    add_column :area_aliases, :begin_date_year, :smallint
    add_column :area_aliases, :begin_date_month, :smallint
    add_column :area_aliases, :begin_date_day, :smallint
    add_column :area_aliases, :end_date_year, :smallint
    add_column :area_aliases, :end_date_month, :smallint
    add_column :area_aliases, :end_date_day, :smallint
  end
end
