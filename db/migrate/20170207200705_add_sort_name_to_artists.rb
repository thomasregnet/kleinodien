class AddSortNameToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :sort_name, :citext
  end
end
