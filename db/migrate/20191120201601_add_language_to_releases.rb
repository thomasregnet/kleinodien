class AddLanguageToReleases < ActiveRecord::Migration[6.0]
  def change
    add_reference :releases, :language, foreign_key: true
  end
end
