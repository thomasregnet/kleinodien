class IndexTrfAttributesOnTrackIdAndNo < ActiveRecord::Migration
  def change
    add_index :trf_attributes, [:track_id, :no], unique: true
  end
end
