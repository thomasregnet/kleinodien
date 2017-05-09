class RenameTrfAttributeKindsToTrackDetailKinds < ActiveRecord::Migration[4.2]
  def change
    rename_table :trf_attribute_kinds, :track_detail_kinds
  end
end
