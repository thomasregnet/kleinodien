class DropSectionFormats < ActiveRecord::Migration[5.0]
  def change
    drop_table :section_formats
  end
end
