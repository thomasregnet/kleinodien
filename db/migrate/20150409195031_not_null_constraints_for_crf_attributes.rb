class NotNullConstraintsForCrfAttributes < ActiveRecord::Migration[4.2]
  def change
    change_column(
      :crf_attributes,
      :cr_format_id,
      :integer,
      null: false
    )
    change_column(
      :crf_attributes,
      :crf_attribute_kind_id,
      :integer,
      null: false
    )
    change_column(
      :crf_attributes,
      :no,
      :integer,
      null: false
    )
  end
end
