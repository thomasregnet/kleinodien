class RenemeCrFormatsColumnFormatIdToFormatKindId < ActiveRecord::Migration
  def change
    rename_column :cr_formats, :format_id, :cr_format_kind_id
  end
end
