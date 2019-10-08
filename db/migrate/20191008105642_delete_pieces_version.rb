class DeletePiecesVersion < ActiveRecord::Migration[6.0]
  def change
    remove_column :pieces, :version
  end
end
