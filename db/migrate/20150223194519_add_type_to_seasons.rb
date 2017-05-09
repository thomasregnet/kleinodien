class AddTypeToSeasons < ActiveRecord::Migration[4.2]
  def change
    add_column :seasons, :type, :string, null: false
  end
end
