class DropCompilationMedia < ActiveRecord::Migration
  def change
    drop_table :compilation_media
  end
end
