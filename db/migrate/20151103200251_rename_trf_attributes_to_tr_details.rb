class RenameTrfAttributesToTrDetails < ActiveRecord::Migration
  def change
    rename_table :trf_attributes, :track_details
  end
end
