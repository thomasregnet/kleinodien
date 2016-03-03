class FkCrfDeteilsReferencesCrfDetailKinds < ActiveRecord::Migration
  def change
    add_foreign_key :crf_details, :crf_detail_kinds
  end
end
