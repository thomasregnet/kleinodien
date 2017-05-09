class RenameTrfAttributesToTrDetails < ActiveRecord::Migration[4.2]
  def change
    rename_table :trf_attributes, :track_details
  end
end
