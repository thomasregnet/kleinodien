class RenameCrfAttributeKindssToCrfDetailKinds < ActiveRecord::Migration[4.2]
  def change
    rename_table :crf_attribute_kinds, :crf_detail_kinds
  end
end
