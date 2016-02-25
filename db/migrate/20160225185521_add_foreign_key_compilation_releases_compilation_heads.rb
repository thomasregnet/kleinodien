class AddForeignKeyCompilationReleasesCompilationHeads < ActiveRecord::Migration
  def change
    add_foreign_key :compilation_releases, :compilation_heads
  end
end
