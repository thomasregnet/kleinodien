class RenameCrFormatsColumnFormatKindIdToFormatId < ActiveRecord::Migration
  def change
    rename_column :cr_formats, :format_kind_id, :format_id
  end
end
