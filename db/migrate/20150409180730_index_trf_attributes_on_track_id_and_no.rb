class IndexTrfAttributesOnTrackIdAndNo < ActiveRecord::Migration[4.2]
  def change
    add_index :trf_attributes, [:track_id, :no], unique: true
  end
end
