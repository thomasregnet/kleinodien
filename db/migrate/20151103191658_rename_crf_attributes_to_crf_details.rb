class RenameCrfAttributesToCrfDetails < ActiveRecord::Migration
  def change
    rename_table :crf_attributes, :crf_details
  end
end
