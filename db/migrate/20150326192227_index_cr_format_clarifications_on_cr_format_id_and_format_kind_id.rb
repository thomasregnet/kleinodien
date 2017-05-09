class IndexCrFormatClarificationsOnCrFormatIdAndFormatKindId < ActiveRecord::Migration[4.2]
  def change
    add_index(
      :cr_format_clarifications, [:cr_format_id, :no],  unique: true
    )
  end
end
