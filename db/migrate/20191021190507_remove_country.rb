class RemoveCountry < ActiveRecord::Migration[6.0]
  def change
    drop_table :countries, force: :cascade
  end
end
