class AddScriptToReleases < ActiveRecord::Migration[6.0]
  def change
    add_reference :releases, :script, foreign_key: true
  end
end
