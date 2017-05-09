class AddReferenceIdToCompilationHead < ActiveRecord::Migration[4.2]
  def change
    add_reference :compilation_heads, :reference, index: true, foreign_key: true
  end
end
