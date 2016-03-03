class IndexCrfDetailsOnCrfDetailKindId < ActiveRecord::Migration
  def change
    add_index :crf_details, :crf_detail_kind_id
  end
end
