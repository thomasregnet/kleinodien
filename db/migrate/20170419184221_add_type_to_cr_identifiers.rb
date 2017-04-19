class AddTypeToCrIdentifiers < ActiveRecord::Migration[5.0]
  def change
    add_column :cr_identifiers, :type, :text, null: false
  end
end
