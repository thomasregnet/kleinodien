class RenameReleaseDataMaskToDateMask < ActiveRecord::Migration[6.0]
  def change
    rename_column :releases, :date_mask, :date_mask
  end
end
