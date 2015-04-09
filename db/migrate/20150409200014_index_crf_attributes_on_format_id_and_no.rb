class IndexCrfAttributesOnFormatIdAndNo < ActiveRecord::Migration
  def change
    add_index :crf_attributes, [:cr_format_id, :no], unique: true
  end
end
