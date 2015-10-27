class AddReferenceIdToCompilationHead < ActiveRecord::Migration
  def change
    add_reference :compilation_heads, :reference, index: true, foreign_key: true
  end
end
