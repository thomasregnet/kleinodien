class RenameReleaseDataMaskToDateMask < ActiveRecord::Migration[6.0]
  def change
    rename_column :releases, :data_mask, :date_mask
  end
end
