class RenameCrfAttributeKindssToCrfDetailKinds < ActiveRecord::Migration
  def change
    rename_table :crf_attribute_kinds, :crf_detail_kinds
  end
end
