class RenameCrFormatClarificationsColumnFormatKindIdToFormatId < ActiveRecord::Migration
  def change
    rename_column :cr_format_clarifications, :format_kind_id, :format_id
  end
end
