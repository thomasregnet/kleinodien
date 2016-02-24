class AddIndexCrFormatsCrFormatKindId < ActiveRecord::Migration
  def change
    add_index :cr_formats, :cr_format_kind_id
  end
end
