class DropTableFormats < ActiveRecord::Migration[4.2]
  def change
    drop_table :formats
  end
end
