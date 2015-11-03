class RenameTrfAttributesToTrDetails < ActiveRecord::Migration
  def change
    rename_table :trf_attributes, :tr_details
  end
end
