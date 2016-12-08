class DropUnusedFormatDetailTables < ActiveRecord::Migration[5.0]
  def change
    tables = %w(
      crf_detail_kinds
      crf_details
      ref_details
      repository_ref_details
      track_detail_kinds
    )
    tables.each { |table| execute "DROP TABLE #{table} CASCADE;" }
  end
end
