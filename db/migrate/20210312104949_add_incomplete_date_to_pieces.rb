class AddIncompleteDateToPieces < ActiveRecord::Migration[6.1]
  def change
    remove_column :pieces, :date, :date
    remove_column :pieces, :date_mask, :smallint

    add_column :pieces, :date_year, :smallint
    add_column :pieces, :date_month, :smallint
    add_column :pieces, :date_day, :smallint
  end
end
