class IndexCrfDetailsOnCrfDetailKindId < ActiveRecord::Migration[4.2]
  def change
    add_index :crf_details, :crf_detail_kind_id
  end
end
