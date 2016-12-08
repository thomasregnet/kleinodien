class DropUnusedFormatTables < ActiveRecord::Migration[5.0]
  def change
    tables = %w(
      cr_formats
      cr_format_kinds
      ct_formats
      pt_formats
      re_formats
      tr_format_kinds
    )
    tables.each { |table| execute "DROP TABLE #{table} CASCADE;" }
  end
end
