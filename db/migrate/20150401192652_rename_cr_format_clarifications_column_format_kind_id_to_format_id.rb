class RenameCrFormatClarificationsColumnFormatKindIdToFormatId < ActiveRecord::Migration[4.2]
  def change
    rename_column :cr_format_clarifications, :format_kind_id, :format_id
  end
end
