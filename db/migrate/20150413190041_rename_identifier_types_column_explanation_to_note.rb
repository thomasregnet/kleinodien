class RenameIdentifierTypesColumnExplanationToNote < ActiveRecord::Migration[4.2]
  def change
    rename_column(:identifier_types, :explanation, :note)
  end
end
