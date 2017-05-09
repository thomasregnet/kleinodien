class RenameCrfAttributesToCrfDetails < ActiveRecord::Migration[4.2]
  def change
    rename_table :crf_attributes, :crf_details
  end
end
