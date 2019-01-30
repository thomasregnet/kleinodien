class AddTitleAndDisambiguationToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :title, :string, null: false
    add_column :pieces, :disambiguation, :string
  end
end
