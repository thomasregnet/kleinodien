class DropTableFormats < ActiveRecord::Migration
  def change
    drop_table :formats
  end
end
