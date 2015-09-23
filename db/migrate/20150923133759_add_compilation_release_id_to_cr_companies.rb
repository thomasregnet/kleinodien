class AddCompilationReleaseIdToCrCompanies < ActiveRecord::Migration
  def change
    add_column :cr_companies, :compilation_release_id, :integer, null: false
  end
end
