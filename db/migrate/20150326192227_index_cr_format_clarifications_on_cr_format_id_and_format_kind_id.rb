class IndexCrFormatClarificationsOnCrFormatIdAndFormatKindId < ActiveRecord::Migration
  def change
    add_index(
      :cr_format_clarifications, [:cr_format_id, :no],  unique: true
    )
  end
end
