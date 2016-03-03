class RenameCrfDetailCrfAttributeKindIdToCrfDetailKindId < ActiveRecord::Migration
  def change
    rename_column :crf_details, :crf_attribute_kind_id, :crf_detail_kind_id
  end
end
