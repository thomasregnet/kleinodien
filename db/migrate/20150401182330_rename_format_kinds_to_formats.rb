class RenameFormatKindsToFormats < ActiveRecord::Migration[4.2]
  def change
    rename_table :format_kinds, :formats
  end
end
