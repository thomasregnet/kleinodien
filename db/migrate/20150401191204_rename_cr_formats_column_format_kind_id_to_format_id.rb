class RenameCrFormatsColumnFormatKindIdToFormatId < ActiveRecord::Migration[4.2]
  def change
    rename_column :cr_formats, :format_kind_id, :format_id
  end
end
