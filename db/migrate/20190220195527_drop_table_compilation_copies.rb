class DropTableCompilationCopies < ActiveRecord::Migration[5.2]
  def change
    drop_table :compilation_copies
  end
end
