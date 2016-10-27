class RepositoryFormatAttributesToDetails < ActiveRecord::Migration[5.0]
  def change
    rename_table :ref_attributes, :ref_details
    rename_table :repository_position_rpf_attributes,
                 :repository_ref_details
    rename_column :repository_ref_details,
                  :ref_attribute_name,
                  :name
  end
end
