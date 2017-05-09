class DropCompilationMedia < ActiveRecord::Migration[4.2]
  def change
    drop_table :compilation_media
  end
end
