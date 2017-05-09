class AddCompilationReleaseIdToCrCompanies < ActiveRecord::Migration[4.2]
  def change
    add_column :cr_companies, :compilation_release_id, :integer, null: false
  end
end
