class FkCrCompaniesCompilationReleaseId < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :cr_companies, :compilation_releases
  end
end
