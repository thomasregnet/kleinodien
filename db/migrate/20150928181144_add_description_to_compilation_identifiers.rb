class AddDescriptionToCompilationIdentifiers < ActiveRecord::Migration
  def change
    add_column :compilation_identifiers, :description, :string
  end
end
