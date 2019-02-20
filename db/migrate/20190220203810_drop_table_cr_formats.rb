class DropTableCrFormats < ActiveRecord::Migration[5.2]
  def change
    drop_table :cr_format_details
    drop_table :cr_formats
  end
end
