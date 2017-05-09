class FkCrfDeteilsReferencesCrfDetailKinds < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :crf_details, :crf_detail_kinds
  end
end
