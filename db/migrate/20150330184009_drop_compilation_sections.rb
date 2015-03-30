class DropCompilationSections < ActiveRecord::Migration
  def change
    drop_table :compilation_sections
  end
end
