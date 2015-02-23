class AddTypeToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :type, :string, null: false
  end
end
