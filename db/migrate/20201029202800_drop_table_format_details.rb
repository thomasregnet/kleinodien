class DropTableFormatDetails < ActiveRecord::Migration[6.0]
  def change
    drop_table :format_details
  end
end
