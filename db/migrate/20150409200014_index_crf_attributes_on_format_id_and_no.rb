class IndexCrfAttributesOnFormatIdAndNo < ActiveRecord::Migration[4.2]
  def change
    add_index :crf_attributes, [:cr_format_id, :no], unique: true
  end
end
