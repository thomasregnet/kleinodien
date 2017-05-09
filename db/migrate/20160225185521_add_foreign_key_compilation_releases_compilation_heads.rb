class AddForeignKeyCompilationReleasesCompilationHeads < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :compilation_releases, :compilation_heads
  end
end
