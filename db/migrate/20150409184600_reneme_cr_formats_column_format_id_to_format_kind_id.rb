class RenemeCrFormatsColumnFormatIdToFormatKindId < ActiveRecord::Migration[4.2]
  def change
    rename_column :cr_formats, :format_id, :cr_format_kind_id
  end
end
