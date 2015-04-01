class RenameFormatKindsToFormats < ActiveRecord::Migration
  def change
    rename_table :format_kinds, :formats
  end
end
