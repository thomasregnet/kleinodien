class RenameIdentifierTypesColumnExplanationToNote < ActiveRecord::Migration
  def change
    rename_column(:identifier_types, :explanation, :note)
  end
end
