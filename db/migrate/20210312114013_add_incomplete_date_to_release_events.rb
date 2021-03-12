class AddIncompleteDateToReleaseEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :release_events, :date, :date
    remove_column :release_events, :date_mask, :smallint

    add_column :release_events, :date_year, :smallint
    add_column :release_events, :date_month, :smallint
    add_column :release_events, :date_day, :smallint
  end
end
