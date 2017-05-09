class AddIndexCrFormatsCrFormatKindId < ActiveRecord::Migration[4.2]
  def change
    add_index :cr_formats, :cr_format_kind_id
  end
end
