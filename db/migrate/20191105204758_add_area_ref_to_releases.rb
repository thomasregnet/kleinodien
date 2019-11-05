class AddAreaRefToReleases < ActiveRecord::Migration[6.0]
  def change
    add_reference :releases, :area, foreign_key: true
  end
end
