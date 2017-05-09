class DropCrFormatClarifications < ActiveRecord::Migration[4.2]
  def change
    remove_index(
      :cr_format_clarifications,
      name: :index_cr_format_clarifications_on_cr_format_id_and_no
    )
    drop_table(:cr_format_clarifications)
  end
end
