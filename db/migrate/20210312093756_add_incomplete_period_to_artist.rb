class AddIncompletePeriodToArtist < ActiveRecord::Migration[6.1]
  def change
    remove_column :artists, :begin_date, :date
    remove_column :artists, :begin_date_mask, :smallint
    remove_column :artists, :end_date, :date
    remove_column :artists, :end_date_mask, :smallint

    add_column :artists, :begin_date_year, :smallint
    add_column :artists, :begin_date_month, :smallint
    add_column :artists, :begin_date_day, :smallint
    add_column :artists, :end_date_year, :smallint
    add_column :artists, :end_date_month, :smallint
    add_column :artists, :end_date_day, :smallint
  end
end
