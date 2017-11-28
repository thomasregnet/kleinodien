class AddDataImportToCompilationHeads < ActiveRecord::Migration[5.1]
  def change
    add_reference :compilation_heads, :data_import, foreign_key: true
  end
end
