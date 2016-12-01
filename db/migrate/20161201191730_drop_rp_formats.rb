class DropRpFormats < ActiveRecord::Migration[5.0]
  def change
    drop_table :rp_formats
  end
end
