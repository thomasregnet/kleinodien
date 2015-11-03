class RenameTrfAttributeKindsToTrackDetailKinds < ActiveRecord::Migration
  def change
    rename_table :trf_attribute_kinds, :track_detail_kinds
  end
end
